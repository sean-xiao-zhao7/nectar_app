import 'package:firebase_ai/firebase_ai.dart';

/// Service class to handle metadata schema extraction using Firebase AI Logic
class AICardRecognitionService {
  late final GenerativeModel _model;

  // System instructions defining the exact schema structure and rules
  static const String _systemPrompt = '''
You are an entity metadata extractor. Given a URL, handle, or text about an individual, brand, musician, or business, extract and return a single valid JSON object following this exact schema.

### JSON Schema Output Structure:
{
  "person_name": "Full name of the individual (if applicable, else empty string)",
  "company": {
    "company_name": "Official company/group/brand name (else empty string)",
    "business_type": "Primary industry or domain (e.g. 'Music Production / Performing Arts')",
    "role": "Title or primary function (e.g. 'Singer-Songwriter', 'Founder')",
    "department": ""
  },
  "short_description": "1-2 concise sentences summarizing who or what this entity is.",
  "address": {
    "street": "",
    "city": "City name if known",
    "state": "State/Province if known",
    "postal_code": "",
    "country": "Country if known"
  },
  "phone": "Phone number if known, else empty string",
  "email": "Email address if known, else empty string",
  "social_media": {
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

  AICardRecognitionService() {
    // Access Gemini via Firebase AI Logic
    _model = FirebaseAI.instance.generativeModel(
      model: 'gemini-2.5-flash',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json', // Forces structured JSON output
        temperature: 0.1, // Low temperature for deterministic output
      ),
      systemInstruction: Content.system(_systemPrompt),
    );
  }

  /// Extracts structured JSON schema for a given URL or entity context string
  Future<String> extractSchema(String input) async {
    try {
      final response = await _model.generateContent([
        Content.text('Extract schema for: $input'),
      ]);

      return response.text ?? '{}';
    } catch (e) {
      // Handle Firebase AI or network exceptions
      rethrow;
    }
  }
}
