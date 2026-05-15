/// Example: How to use the AI Script Generator Feature
///
/// This file demonstrates how to integrate and use the AI Script Generator
/// in your CineHub app.
library;

// STEP 1: Import the module
import 'package:cinehubapp/ai_features/ai_features.dart';
import 'package:flutter/material.dart';

// STEP 2: Define your API key (store securely - see README.md for best practices)
const String GEMINI_API_KEY = 'AIzaSyBbpB2fBJbYj443ffE4WFDy2qnF4V4zdLg';

// STEP 3: Navigate to the AI Script Generator Screen
class ExampleNavigationToAIGenerator {
  static void navigateToAIScriptGenerator(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AIScriptGeneratorScreen(
          apiKey: GEMINI_API_KEY,
        ),
      ),
    );
  }
}

// STEP 4: Add to your app's main navigation menu
class ExampleUserNavigationMenu extends StatelessWidget {
  const ExampleUserNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ... other menu items ...
        
        ListTile(
          leading: const Icon(Icons.auto_awesome),
          title: const Text('🎬 AI Script Generator'),
          subtitle: const Text('Generate screenplays with AI'),
          onTap: () => ExampleNavigationToAIGenerator.navigateToAIScriptGenerator(context),
        ),
        
        // ... other menu items ...
      ],
    );
  }
}

// STEP 5: Use directly in a function or button
class ExampleButtonToLaunchGenerator extends StatelessWidget {
  const ExampleButtonToLaunchGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AIScriptGeneratorScreen(
              apiKey: GEMINI_API_KEY,
            ),
          ),
        );
      },
      icon: const Icon(Icons.auto_awesome),
      label: const Text('Generate Script'),
    );
  }
}

// STEP 6: Advanced - Custom service usage
class ExampleAdvancedServiceUsage {
  static Future<void> generateScriptProgrammatically() async {
    final service = ScriptGeneratorService(apiKey: GEMINI_API_KEY);
    
    try {
      final request = ScriptGenerationRequest(
        genre: ScriptGenre.thriller,
        duration: ScriptDuration.tenMin,
        theme: 'A heist gone wrong',
        characters: ['Master Thief', 'Detective', 'Informant'],
        style: ScriptStyle.cinematic,
        additionalNotes: 'Include plot twists',
      );
      
      final response = await service.generateScript(request);
      
      print('Story Outline: ${response.storyOutline}');
      print('Screenplay: ${response.screenplay}');
      print('Dialogues: ${response.dialogues}');
      print('Shot Suggestions: ${response.shotSuggestions}');
    } catch (e) {
      print('Error: $e');
    }
  }
}

// STEP 7: Setup in your routes configuration
class ExampleRouteConfiguration {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/ai-script-generator': (context) => AIScriptGeneratorScreen(
        apiKey: GEMINI_API_KEY,
      ),
      // ... other routes ...
    };
  }
}

// STEP 8: Integration with your existing screens
class ExampleHomeScreenIntegration extends StatelessWidget {
  const ExampleHomeScreenIntegration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CineHub')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ... existing content ...
            
            Card(
              child: ListTile(
                title: const Text('🔥 AI Script Generator'),
                subtitle: const Text('Create screenplays instantly'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AIScriptGeneratorScreen(
                        apiKey: GEMINI_API_KEY,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // ... more content ...
          ],
        ),
      ),
    );
  }
}

// SECURITY BEST PRACTICE: Using Environment Variables
// 
// For production, use environment variables instead:
//
// 1. Add to .env file (add .env to .gitignore):
//    GEMINI_API_KEY=AIzaSyBbpB2fBJbYj443ffE4WFDy2qnF4V4zdLg
//
// 2. Load at app startup (use flutter_dotenv package):
//    import 'package:flutter_dotenv/flutter_dotenv.dart';
//    
//    void main() async {
//      await dotenv.load();
//      runApp(const MyApp());
//    }
//
// 3. Use in your code:
//    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

// EXAMPLE FEATURE: Custom Script Model Integration
class ExampleSavingGeneratedScript {
  // You could extend this to save scripts to a database
  static void saveGeneratedScript(
    ScriptGenerationResponse script,
    String title,
  ) {
    // Example: Save to SQLite, Firebase, or backend API
    // final scriptData = {
    //   'title': title,
    //   'storyOutline': script.storyOutline,
    //   'screenplay': script.screenplay,
    //   'dialogues': script.dialogues,
    //   'shotSuggestions': script.shotSuggestions,
    //   'generatedAt': script.generatedAt,
    // };
    // 
    // // Call your database or API to save scriptData
  }
}
