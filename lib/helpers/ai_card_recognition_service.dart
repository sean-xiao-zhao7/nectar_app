import 'dart:convert';
import 'dart:io';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:nectar_app/models/nectar_card.dart';

/// Generate NectarCard based on prompt schema.
///
class AICardRecognitionService {
  static const String _nectarCardSchemaPrompt = '''
You are an entity metadata extractor. Given a URL, handle, or text about an individual, brand, musician, or business, extract and return a single valid JSON object following this exact schema.

### JSON Schema Output Structure:
{  
  "mainName": "A name that best represents this person or entity, besides the first and/or last names.",
  "shortDescription": "1-2 concise sentences summarizing who or what this entity is.",
  "personalInfo" : {
    "firstName": "First name of the individual (if applicable, else empty string)",
    "lastName": "Last name of the individual (if applicable, else empty string)",    
    "phone": "Phone number if known, else empty string",
    "email": "Email address if known, else empty string",    
  },
  "companyInfo": {
    "companyName": "Official company/group/brand name (else empty string)",
    "businessType": "Primary industry or domain (e.g. 'Music Production / Performing Arts')",
    "role": "Title or primary function (e.g. 'Singer-Songwriter', 'Founder')",
    "department": ""
  },
  "addressInfo": {
    "street": "",
    "city": "City name if known",
    "state": "State/Province if known",
    "postalCode": "",
    "country": "Country if known"
  },
  "socialMedia": {
    "website": "Official website or primary platform URL",
    "linkedin": "LinkedIn handle/username or path",
    "twitter": "X/Twitter handle (without @)",
    "instagram": "Instagram handle (without @)",
    "facebook": "Facebook page username or page ID"
  }
}

### Field Rules:
1. For missing or unknown details, return an empty string (""). Do NOT use "N/A", "Unknown", or null.
2. For social media platforms (instagram, twitter, facebook), output ONLY the handle/username (e.g., 'i.gram.iri'), NOT full URLs.
3. For 'website', provide the official domain URL or main platform landing link.
4. Return ONLY valid, parseable JSON with no conversational text or wrapping outside the JSON object.
''';

  /// Extracts structured JSON schema for a given URL or entity context string
  static Future<String> extractSchema(String input, {String? imagePath}) async {
    try {
      final List<Content> modelInputs = [];

      if (imagePath != null) {
        final image = await File(imagePath).readAsBytes();
        final imagePart = InlineDataPart('image/jpeg', image);
        modelInputs.add(
            Content.multi([TextPart('Extract schema for: $input'), imagePart]));
      } else {
        modelInputs.add(Content.text('Extract schema for: $input'));
      }

      final model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-3.6-flash',
        systemInstruction: Content.system(_nectarCardSchemaPrompt),
      );
      final prompt = [Content.text('Make a schema for $input.')];
      final response = await model.generateContent(prompt);

      return response.text ?? '{}';
    } catch (e) {
      // Handle Firebase AI or network exceptions
      rethrow;
    }
  }

  // Generate a NectarCard class based on A.I. analysis.
  // Prompt is either a text URL or an user-uploaded image.
  static Future<NectarCard> generateNectarCard(String sourceURL,
      {String? imagePath}) async {
    try {
      String aiAnalysis = await extractSchema(sourceURL);
      Map<String, dynamic> jsonResult = jsonDecode(aiAnalysis);
      NectarCard newCard = NectarCard(
          ownerUserId: 'ownerUserId Test',
          mainName: 'Main Name Test',
          personalInfo: jsonResult['personalInfo'],
          addressInfo: jsonResult['addressInfo'],
          companyInfo: jsonResult['companyInfo'],
          socialMedia: jsonResult['socialMedia']);
      return newCard;
    } catch (error) {
      rethrow;
    }
  }
}
