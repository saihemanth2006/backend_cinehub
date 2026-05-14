# AI Features Module 🎬

This module implements advanced AI-powered features for the CineHub app, starting with the **AI Script Generator**.

## Features Included

### 🔥 AI Script Generator

Automatically generates professional screenplays, story outlines, dialogues, and shot suggestions using Google's Gemini API.

#### What It Generates

- **Story Outline**: A detailed beginning, middle, and end story structure
- **Screenplay**: Production-ready screenplay with scene breakdowns
- **Dialogues**: Key dialogue lines for the entire script
- **Shot Suggestions**: Specific camera angles and movements for each scene

#### Input Parameters

- **Genre**: Action, Romance, Thriller, Comedy, Drama, Horror, Science Fiction
- **Duration**: 5 min, 10 min, 15 min, 20 min
- **Theme/Message**: The core theme or message of the story
- **Characters** (Optional): Comma-separated character names
- **Style**: Cinematic, Comedy, Dark, Documentary, Experimental
- **Additional Notes** (Optional): Any specific requirements

## Setup Instructions

### 1. Install Required Dependencies

Add the `http` package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0 # or latest version
```

Run:

```bash
flutter pub get
```

### 2. Provide Gemini API Key

You have two options:

#### Option A: Environment Variable (Recommended for Production)

Store the API key as an environment variable and read it at runtime:

```dart
import 'dart:io';

final apiKey = Platform.environment['GEMINI_API_KEY']!;
```

#### Option B: Direct Configuration (Development)

Pass the API key directly when creating the screen:

```dart
final apiKey = 'AIzaSyBbpB2fBJbYj443ffE4WFDy2qnF4V4zdLg';
```

### 3. Important: Never Commit API Keys

Add the API key to `.gitignore`:

```
.env
*.key
api_key.dart
```

## Integration Example

### In Your Main App Navigation

```dart
import 'package:cinehubapp/ai_features/ai_features.dart';

// In your navigation or router
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => AIScriptGeneratorScreen(
      apiKey: 'YOUR_GEMINI_API_KEY_HERE',
    ),
  ),
);
```

### Add to Your Navigation Menu

Update your navigation to include the AI Script Generator:

```dart
ListTile(
  leading: const Icon(Icons.auto_awesome),
  title: const Text('AI Script Generator'),
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AIScriptGeneratorScreen(
          apiKey: apiKey,
        ),
      ),
    );
  },
)
```

## File Structure

```
lib/ai_features/
├── ai_features.dart                 # Module exports
├── script_generator_service.dart    # Gemini API integration
├── models/
│   └── script_models.dart           # Data models & enums
└── screens/
    └── ai_script_generator_screen.dart  # UI implementation
```

## File Descriptions

### Models (`script_models.dart`)

- **ScriptGenre**: Enum for available genres
- **ScriptDuration**: Enum for video durations
- **ScriptStyle**: Enum for output styles
- **ScriptGenerationRequest**: Input data structure
- **ScriptGenerationResponse**: Generated script structure

### Service (`script_generator_service.dart`)

- **ScriptGeneratorService**: Handles API communication with Gemini
- Uses `gemini-1.5-pro` model (best for creative content)
- Alternative: `gemini-2.0-flash` (faster responses)
- Automatic JSON parsing from AI responses
- Error handling and timeouts

### Screen (`ai_script_generator_screen.dart`)

- **AIScriptGeneratorScreen**: Complete UI
- Form for script parameters
- Real-time loading feedback
- Results display with expandable sections
- Copy and export functionality (extensible)

## API Response Format

The Gemini API returns responses in this JSON structure:

```json
{
  "storyOutline": "Detailed story outline...",
  "screenplay": "Scene-by-scene screenplay...",
  "dialogues": ["Dialogue 1", "Dialogue 2", ...],
  "shotSuggestions": ["Shot 1: Description", "Shot 2: Description", ...]
}
```

## Best Practices

### 1. API Key Management

- ✅ Store keys in environment variables
- ✅ Use `.gitignore` to prevent accidental commits
- ❌ Never hardcode keys in source files
- ❌ Never commit keys to version control

### 2. Configuration

The service uses optimized settings:

- **Temperature**: 0.9 (creative, varied outputs)
- **Top K**: 40 (diversity)
- **Top P**: 0.95 (quality)
- **Max Output Tokens**: 4096 (longer scripts)
- **Timeout**: 2 minutes (for complex generations)

### 3. Error Handling

The service includes:

- Network error handling
- API error responses
- JSON parsing errors
- Request timeouts

### 4. Performance

- Asynchronous API calls prevent UI blocking
- Loading indicator during generation
- Future enhancements:
  - Response caching
  - Batch generation
  - Background processing

## Security Considerations

⚠️ **Important**: This API key is exposed in client-side code. For production:

### Option 1: Backend API Gateway (Recommended)

Create a backend endpoint that:

1. Receives script requests from client
2. Authenticates the user
3. Calls Gemini API with server-side key
4. Returns results to client

Example backend pseudocode:

```
POST /api/generate-script
├── Validate user authentication
├── Validate request parameters
├── Call Gemini API (server-side key)
└── Return generated script
```

### Option 2: Firebase Functions

Use Firebase Cloud Functions to:

1. Handle API calls securely
2. Manage rate limiting
3. Store keys in Firebase Secrets

## Future Enhancements

- [ ] Response caching (SQLite/local storage)
- [ ] Batch generation (multiple scripts)
- [ ] PDF export functionality
- [ ] Script collaboration features
- [ ] Voice-based inputs
- [ ] Custom model fine-tuning
- [ ] Character consistency across scenes
- [ ] Visual storyboard generation
- [ ] Multi-language support
- [ ] Advanced editing features

## Recommended LLM Model: Gemini 1.5 Pro ✨

**Why Gemini 1.5 Pro?**

- Large context window (handles long screenplays)
- Superior creative writing quality
- Better reasoning for structured outputs
- Consistent dialogue writing
- Excellent shot descriptions

**Alternative: Gemini 2.0 Flash**

- Faster response times
- Slightly lower quality than Pro
- Good for quick iterations
- Lower API costs

**Model Comparison**:
| Feature | 1.5 Pro | 2.0 Flash |
|---------|---------|-----------|
| Quality | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Speed | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Cost | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Context | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |

## Troubleshooting

### "No content generated from API"

- Check API key validity
- Verify internet connection
- Check Gemini API status

### "Error parsing script response"

- Ensure theme is descriptive
- API may not have returned valid JSON
- Try again with different parameters

### "Request timeout"

- Reduce script duration
- Simplify theme/parameters
- Check network connection
- API might be overloaded

### "401 Unauthorized"

- Verify API key is correct
- Check key hasn't been revoked
- Ensure billing is enabled on Google Cloud

## Support & Feedback

For issues or feature requests:

1. Check troubleshooting section
2. Review API response in logs
3. Contact development team
4. Report bugs with:
   - Script parameters used
   - Error message
   - Device/OS info
   - Steps to reproduce

---

**API Endpoint**: https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent

**Documentation**: https://ai.google.dev/docs
