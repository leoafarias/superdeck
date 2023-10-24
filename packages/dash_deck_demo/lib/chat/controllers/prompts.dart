String codeAssistantPrompt(String context, String query) {
  return '''
You are a helpful knowledgable Dart code assistant. You are able to answer a user's query, and provide the best response possible given PROJECT_CONTEXT.

Your output should always be in a very detailed markdown syntax.

### PROJECT_CONTEXT
$context

### QUERY
$query
  ''';
}

String queryAnalysisPrompt(String context, String query) {
  return '''
You are a Dart codebase senior developer. You are able to analyze a user's query, and determine which entities, and file paths that are the most relevant to the user's query based on the given PROJECT_CONTEXT\n$context\n\n.\n\nThink step by step about what are the 3 most important entities and their corresponding file paths.\n\nPlease order the entities and file paths by importance.\n\n\nThe Examples I provide, are for how I would like you to respond to the input, but since the PROJECT_CONTEXT is always dynamic, I want you to focus just  on the output for the examples, as you walk through the PROJECT_CONTEX\n\n### PROJECT_CONTEXT\ninput: Tell me about the ChatController\noutput: 1. Entity: `ChatController`\n   - FilePath: /Users/leofarias/Projects/sidekick/lib/src/modules/chat/controllers/chat_controller.dart\n   - Description: The `ChatController` class is primarily responsible for facilitating chat interactions. It is essential for managing the state and interactions within the chat module of the application.\n\n2. Method: `ChatState build`\n    - Description: This method is likely responsible for constructing the initial state of the chat module in the application. In state management, such methods commonly provide initial states or values to the components.\n\n3. Method: `Future&lt;void&gt; sendMessage(ChatMessage message)`\n    - Description: The `sendMessage` method manages the sending of chat messages. It is likely responsible for adding new messages to the chat history and may trigger the chatbot's response mechanism.\ninput: Give me the most important controllers in this project\noutput: 1. ChatController:\n    - Path: /Users/leofarias/Projects/sidekick/lib/src/modules/chat/controllers/chat_controller.dart\n    - This controller seems critical as it manages the chat functions of the application. It holds methods necessary for loading, resetting, sending messages and converting messages.\n\n2. ProjectController:\n    - Path: /Users/leofarias/Projects/sidekick/lib/src/modules/projects/projects.controller.dart\n    - This controller manages the projects within the application. It provides methods related to initializing, saving, project activation, addition and removal.\n\n3. NavigationProvider:\n    - Path: /Users/leofarias/Projects/sidekick/lib/src/modules/navigation/navigation.provider.dart\n    - This controller is important for the navigation of the application. It provides methods for handling navigation events.\n\ninput: $query\noutput:
''';
}

String projectReferenceConverterPrompt(String input) {
  return '''
You will receive an input that has information about some of the most important entities, and also a list of file paths.

Your job is to review the input and return a valid json with the following format.

Only respond with the valid json like this

Examples

Input: (sample)
Output:{
  "entities": [
    "entity_1",
    "entity_2",
    "entity_3"
  ],
  "paths": [
    "path_1",
    "path_2",
    "path_3"
  ]
}

Input: (other sample)
Output: {
  "entities": [
    "entity_1",
    "entity_2",
    "entity_3"
  ],
  "paths": [
    "path_1",
    "path_2",
    "path_3"
  ]
}

Input: $input \n
Output:
''';
}
