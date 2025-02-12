"
This baseline is used to generate Pharo images from the local clone of pharo-project/pharo repository. 

Depends on:
- BasicTools
- Traits
- Shift
- Slots
- Athens

Load type: 
- linear

Installs:
- Epicea
- decompiler
- tests
- refactoring
- GT Tools
- Versionner
- TxText
- OSWindow
- QualityAssistant
- some other packages
 
"
Class {
	#name : #BaselineOfIDE,
	#superclass : #BaselineOf,
	#classVars : [
		'Initialized'
	],
	#category : #BaselineOfIDE
}

{ #category : #actions }
BaselineOfIDE >> additionalInitialization [

	self class environment at: #GTGenericStackDebugger ifPresent: [
	  Smalltalk tools register: GTGenericStackDebugger as: #debugger.
	  Smalltalk tools registeredDebuggersWithRanks.
	  Smalltalk tools debuggers add: ((self class environment at: #GTGenericStackDebugger)->3).
	  Smalltalk tools debuggers add: ((self class environment at: #GTSUnitDebugger)->70).
	  Smalltalk tools debuggers add: ((self class environment at: #GTBytecodeDebugger)->5).].

	  
	self class environment at: #GTPlayground ifPresent: [:playground | 
	  Smalltalk tools register: playground as: #workspace.].
	self class environment at: #GTInspector ifPresent: [:inspector | 
	  Smalltalk tools register: inspector as: #inspector.].

	Smalltalk tools register: ExternalChangesBrowser as: #changeList.
	Smalltalk tools register: FileList as: #fileList.
	Smalltalk tools register: Finder as: #finder.
	Smalltalk tools register: ProcessBrowser as: #processBrowser.
	Smalltalk tools register: RecentMessageList as: #recentMessageList.
	Smalltalk tools register: SyntaxErrorDebugger as: #syntaxErrorDebugger.
	Smalltalk tools register: TimeProfiler as: #timeProfiler.

	(MorphicCoreUIManager classPool at: #UIProcess) ifNotNil: [ :proc | proc terminate ].
	MorphicCoreUIManager classPool at: #UIProcess put: nil.

	PolymorphSystemSettings desktopColor:  Color veryVeryLightGray lighter.
	SourceCodeFonts setSourceCodeFonts: 10.
	LogicalFontManager unload.
	FreeTypeSystemSettings loadFt2Library: true.
	FreeTypeSettings current monitorType: #LCD.
	FreeTypeSettings current glyphContrast: 55.
	
	CatalogSettings displayCatalogProjectsInSpotter: false.

	RealEstateAgent usedStrategy: #cascadeFor:initialExtent:world:.
	GrowlMorph position: #bottomLeft.
	ShortcutReminder enabled: true.

	KMRepository reset.
	Morph shortcutsHandler: KMShortcutHandler new.

	MCSaveVersionDialog previousMessages add: String new.

	RBProgramNode formatterClass: BIConfigurableFormatter.

	Color flushCache.

	ASTTransformExamplePluginActive recompile.
	PharoCommandLineHandler recompile.
	SmalltalkImage recompile.
	
	RubCharacterScanner initialize.
	
	RubAbstractTextArea highlightMessageSend: true.
	
	PharoDarkTheme beCurrent.
	
	SDL_Event initialize.
	
	HiRulerBuilderTest initialize.
	
	3 timesRepeat: [
		Smalltalk garbageCollect.
		Undeclared removeUnreferencedKeys.].
	
	self loadIceberg.	
	self makeCalypsoDefaultBrowser.
]

{ #category : #baseline }
BaselineOfIDE >> baseline: spec [ 
    
	<baseline>

 	| repository | 
	
	repository := self packageRepositoryURL.
       
	spec for: #common do: [
		spec postLoadDoIt: #'postload:package:'.
		
		spec baseline: 'BasicTools' with: [ spec repository: repository ].
		
		spec baseline: 'Athens' with: [ spec repository: repository ].
		spec baseline: 'Flashback' with: [ spec repository: repository ].

		spec baseline: 'Shift' with: [
			spec loads: 'shift-tests'. 
			spec repository: repository
		].

		spec baseline: 'Traits' with: [
			spec loads: 'traits-tests'. 
			spec repository: repository
		].
	
		spec baseline: 'Slot' with: [
			spec loads: 'slot-tests'. 
			spec repository: repository
		].

		spec baseline: 'Clap' with: [ spec repository: repository ].
	
		spec baseline: 'SUnit' with: [
			spec loads: 'Tests'. 
			spec repository: repository
		].
		
		spec package: 'ReleaseTests'. 
		spec package: 'Refactoring-Critics'.
		spec package: 'NautilusRefactoring'.
		spec package: 'NautilusRefactoring-Tests'.

		spec package: 'Ombu'.
		spec package: 'Epicea'.
		spec package: 'Hiedra'.
		spec package: 'EpiceaBrowsers'.
		spec package: 'Hiedra-Examples'.
		spec package: 'Hiedra-Tests'. 
		spec package: 'Ombu-Tests'.
		spec package: 'Epicea-Tests'.
		spec package: 'EpiceaBrowsers-Tests'.

		
		spec package: 'Shout'.
		spec package: 'Reflectivity-Tools'.

		spec package: 'Rubric-Styling'.
		
		spec package: 'BlueInk-Core'.
		
		spec package: 'Transcript-NonInteractive-Tests'.
		spec package: 'Collections-Tests'.
		spec package: 'Text-Tests'.
		spec package: 'Network-Tests'.
		spec package: 'Network-Mail-Tests'.
		spec package: 'Tests'.
		spec package: 'System-Installers-Tests'.
		spec package: 'System-Object Events-Tests'.
		spec package: 'System-OSEnvironments-Tests'.
		spec package: 'Ring-Definitions-Tests-Core'.
		spec package: 'AST-Core-Tests'.
		spec package: 'FileSystem-Tests-Core'.
		spec package: 'Fuel-Tests-Core'.
		spec package: 'Fuel-Platform-Pharo-Core-Tests'.
		spec package: 'Fuel-Tools-Pharo'.
		spec package: 'Gofer-Tests'.
		spec package: 'Kernel-Tests'.
		spec package: 'Kernel-Tests-Extended'.
		spec package: 'Kernel-Tests-WithCompiler'.
		spec package: 'Debugging-Utils-Tests'.
		spec package: 'Manifest-Core'.
		spec package: 'Manifest-Resources-Tests'.
		spec package: 'OpalCompiler-Tests'.
		spec package: 'Refactoring-Tests-Core'.
		spec package: 'Reflectivity-Tests'.
		spec package: 'ReleaseTests'.
		spec package: 'Ring-Definitions-Tests-Containers'.
		spec package: 'Ring-Definitions-Tests-Core'.
		spec package: 'System-DependenciesTests'.
		
		spec package: 'System-Serial Port'.
		
		spec package: 'Zinc-Resource-Meta-Tests'.

		spec package: 'Zodiac-Tests'.	
		spec package: 'Zodiac-Extra'.	
		spec package: 'Zinc-Zodiac'.	
			
		spec package: 'Metacello-TestsMCResources'.
		spec package: 'Metacello-TestsCore'.
		spec package: 'Metacello-TestsCommonMC'.
		spec package: 'Metacello-TestsMC'.	"standalone"
		spec package: 'Metacello-TestsMCCore'.	"standalone"
		spec package: 'Metacello-TestsPlatform'.	"standalone"
		spec package: 'Metacello-TestsReference'.	"standalone"
		spec package: 'Metacello-Gitlab-Tests'.

		spec package: 'RPackage-Tests'.
		spec package: 'Tests'.
		spec package: 'Monticello-Tests'.
		spec package: 'MonticelloGUI-Tests'.

		spec package: 'Glamour-Announcements'.
		spec package: 'Glamour-Helpers'.
		spec package: 'Glamour-Core'.
		spec package: 'Glamour-Tasks'.
		spec package: 'Glamour-PagerModel'.
		spec package: 'Glamour-Presentations'.
		spec package: 'Glamour-Browsers'.
		spec package: 'Glamour-Morphic-Brick'.
		spec package: 'Glamour-Tests-Core'.
		spec package: 'Glamour-Tests-Resources'.
		spec package: 'Glamour-Morphic-Theme'.
		spec package: 'Glamour-Morphic-Widgets'.
		spec package: 'Glamour-Morphic-Renderer'.
		spec package: 'Glamour-Morphic-Pager'.
		spec package: 'Glamour-Tests-Morphic'.
		spec package: 'Glamour-Rubric-Presentations'.
		spec package: 'Glamour-FastTable'.
		spec package: 'Glamour-SpecIntegration'.
	
		spec package: 'GT-Inspector'.
		spec package: 'GT-InspectorExtensions-Core'.

		spec package: 'GT-Playground'.

		spec package: 'GT-EventRecorder'.

		spec package: 'GT-Spotter'.
		spec package: 'GT-Spotter-UI'.
		spec package: 'GT-SpotterExtensions-Core'.

		spec package: 'Tool-Catalog'.	"standalone"

		spec package: 'GT-Debugger'.
		spec package: 'GT-BytecodeDebugger'.
		spec package: 'GT-SUnitDebugger'.

		spec package: 'Tool-CriticBrowser'.

		spec package: 'Renraku'.
		spec package: 'SUnit-Rules'.	

		spec package: 'Moose-Algos-Graph'.
		spec package: 'Tool-DependencyAnalyser'.
		spec package: 'Tool-DependencyAnalyser-UI'.
		spec package: 'Tool-DependencyAnalyser-Tests'.	"standalone"
		spec package: 'Tool-DependencyAnalyser-Tests-Data'.	"standalone"
 
		spec package: 'Kernel-Rules'.
		spec package: 'SmartSuggestions'.
		
		spec package: 'MonticelloMocks'.
		spec package: 'OpalCompiler-Tools'.

		spec package: 'OSWindow-Core'.
		spec package: 'OSWindow-SDL2'.
		spec package: 'OSWindow-VM'.
				
		spec package: 'System-CommandLine-TextSupport'.
		spec package: 'GeneralRules'.
		spec package: 'GeneralRules-Tests'.
		spec package: 'FuzzyMatcher'.
		spec package: 'STON-Text support'.
		
		"SortFunctions (standalone)"
		spec package: 'SortFunctions-Core'.
		spec package: 'SortFunctions-Tests'.

		"standalone packages"
		spec package: 'Announcements-Help'.
		spec package: 'Announcements-Core-Tests'.
		spec package: 'Balloon-Tests'.
		spec package: 'BlueInk-Extras'.
		spec package: 'BlueInk-Tests'.
		spec package: 'Morphic-Widgets-FastTable-Tests'.
		spec package: 'CodeImport-Tests'.
		spec package: 'Collections-DoubleLinkedList-Tests'.
		spec package: 'Collections-Arithmetic-Tests'.
		spec package: 'Compression-Tests'.
		spec package: 'ConfigurationCommandLineHandler-Tests'.
		spec package: 'MetacelloCommandLineHandler-Tests'.
		spec package: 'Debugger-Tests'.
		spec package: 'EmbeddedFreeType-Tests'.
		spec package: 'FileSystem-Tests-Disk'.
		spec package: 'FileSystem-Tests-Memory'.
		spec package: 'FileSystem-Tests-Attributes'.
		spec package: 'Files-Prompt'.
		spec package: 'Files-Tests'.
		spec package: 'Fonts-Infrastructure-Tests'.
		spec package: 'FreeType-Tests'.
		spec package: 'FreeType-Help'.
		spec package: 'FuzzyMatcher-Tests'.
		spec package: 'GT-Tests-Debugger'.
		spec package: 'GT-Tests-Inspector'.
		spec package: 'GT-Tests-Playground'.
		spec package: 'GT-Tests-Spotter'.
		spec package: 'Glamour-Morphic-Brick-Tests'.
		spec package: 'Glamour-Tests-Rubric'.
		spec package: 'Graphics-Tests'.
		spec package: 'HelpSystem-Tests'.
		spec package: 'IssueTracking-Tests'.
		spec package: 'Jobs-Tests'.
		spec package: 'Kernel-Tests-Rules'.
		spec package: 'Keymapping-Tests'.
		spec package: 'Manifest-Tests'.
		spec package: 'Morphic-Tests'.
		spec package: 'Multilingual-Tests'.
		spec package: 'NewValueHolder-Tests'.		
		spec package: 'NECompletion-Tests'.
		spec package: 'OSWindow-SDL2-Examples'.
		spec package: 'OSWindow-Tests'.
		spec package: 'PerformMessageCommandLineHandler'.
		spec package: 'Pharo-Help'.
		spec package: 'PharoDocComment'.
		spec package: 'PharoDocComment-Tests'.
		spec package: 'Polymorph-Widgets-Rules'.
		spec package: 'ProfStef-Tests'.
		spec package: 'Random-Tests'.
		spec package: 'Refactoring-Help'.
		spec package: 'Refactoring-Tests-Changes'.
		spec package: 'Refactoring-Tests-Critics'.
		spec package: 'Refactoring-Tests-Environment'.
		spec package: 'ReflectionMirrors-Primitives-Tests'.
		spec package: 'Reflectivity-Examples'.
		spec package: 'Reflectivity-Tools-Tests'.
		spec package: 'Regex-Help'.
		spec package: 'Regex-Core-Tests'.
		spec package: 'Renraku-Help'.
		spec package: 'Renraku-Test'.
		spec package: 'Ring-Definitions-Tests-Monticello'.
		spec package: 'Rubric-Rules'.
		spec package: 'Rubric-Tests'.
		spec package: 'ScriptingExtensions-Tests'.
		spec package: 'STON-Tests'.
		spec package: 'Shout-Tests'.
		spec package: 'SmartSuggestions-Tests'.
		spec package: 'Spec-Tests'.
		spec package: 'System-BasicCommandLineHandler-Tests'.
		spec package: 'System-Caching-Tests'.
		spec package: 'System-Hashing-Tests'.
		spec package: 'System-History-Tests'.
		spec package: 'System-Localization-Tests'.
		spec package: 'System-SessionManager-Tests'.
		spec package: 'System-Settings-Rules'.
		spec package: 'System-Settings-Tests'.
		spec package: 'System-Support-Rules'.
		spec package: 'System-Support-Tests'.
		spec package: 'System-Platforms-Tests'.
		spec package: 'Text-Edition-Tests'.
		spec package: 'Tool-FileList-Tests'.
		spec package: 'Tools-Test'.	
		spec package: 'Zinc-Character-Encoding-Tests'.
		spec package: 'Zinc-Resource-Meta-FileSystem'.			
		spec package: 'Zinc-HTTP-Examples'.
		spec package: 'Zinc-Tests'.
		spec package: 'System-Identification-Tests'.

		spec package: 'BaselineOfPharoBootstrap'.
		spec package: 'BaselineOfMonticello'.
		spec package: 'BaselineOfMetacello'.
		spec package: 'BaselineOfTelePharoSupport'.
		
		spec package: 'ReferenceFinder-Core'.

		spec package: 'Refactoring2-Core'.
		spec package: 'Refactoring2-Transformations'.
		spec package: 'Refactoring2-Transformations-Tests'.

		spec package: 'ClassParser'.
		spec package: 'ClassParser-Tests'.
		spec package: 'UndefinedClasses'.
		spec package: 'UndefinedClasses-Tests'.

		spec baseline: 'Calypso' with: [ 
			spec
				repository: repository;
				loads: #('FullEnvironment' 'SystemBrowser' 'Tests'). ].

                spec baseline: 'Ring' with: [spec repository: repository].


      self groups: spec.
	].

]

{ #category : #baseline }
BaselineOfIDE >> groups: spec [ 
    
spec group: 'Mandatory-Group' with: #(
	'Fuel-Tools-Pharo'	"required by GT-Debugger HudsonBuildTools20"
	'Network-Tests'		"required by Multilingual-Tests"
	'Network-Mail-Tests'	"previously part of Network-Tests"
	'Gofer-Tests'		"required by EpiceaTests Metacello-TestsMC, depends on 'Metacello-Tests-Group', cleanup needed?"
). 

spec group: 'Optional-Group' with: #(
	'Athens' "dependency"

	'PharoDocComment'	"standalone"
	'STON-Text support'	"standalone?"
	'System-CommandLine-TextSupport'	"standalone?"
	'System-Serial Port'	"standalone?"
	'PerformMessageCommandLineHandler' 	"standalone"
	'Files-Prompt'
).				

spec group: 'Epicea-Core-Group' with: #(
	'Athens' "dependency of Hiedra"
	'Ombu'
	'Epicea'
	'Hiedra'
	'Hiedra-Examples'
	'EpiceaBrowsers').
spec group: 'Epicea-Tests-Group' with: #(
	'Ombu-Tests'
	'Epicea-Tests'
	'Hiedra-Tests'
	'EpiceaBrowsers-Tests'
).	
spec group: 'Epicea-Group' with: #(
	'Epicea-Core-Group' 
	'Epicea-Tests-Group'
).	

spec group: 'General-Help-Group' with: #(
	'Announcements-Help'
	'Pharo-Help'
	'Regex-Help'
).	

spec group: 'General-Tests-Group' with: #(
	'Kernel-Tests-Group' "dependency"
	'Debugging-Utils-Tests'
	'Tests'
	'RPackage-Tests'
	'Monticello-Tests'	"required by MonticelloMocks"
	'System-Installers-Tests' 
	'MonticelloMocks'
	'Fuel-Tests-Core'
	'Fuel-Platform-Pharo-Core-Tests'	
	'Balloon-Tests'
	'Collections-DoubleLinkedList-Tests'
	'Collections-Arithmetic-Tests'
	'ConfigurationCommandLineHandler-Tests'
	'MetacelloCommandLineHandler-Tests'
	'Debugger-Tests'
	'EmbeddedFreeType-Tests'
	'Epicea-Tests-Group'
	'FileSystem-Tests-Memory'
	'Fonts-Infrastructure-Tests'
	'FreeType-Tests'
	'FreeType-Help'

	'Graphics-Tests'
	'HelpSystem-Tests'
	'IssueTracking-Tests'
	'Keymapping-Tests'

	'Morphic-Tests'
	
	'Morphic-Widgets-FastTable-Tests'
	'NECompletion-Tests'
	'NewValueHolder-Tests'
	'ProfStef-Tests'
	'Reflectivity-Tools-Tests'
	'Regex-Core-Tests'
	'Ring-Definitions-Tests-Monticello'
	'Rubric-Tests'
	'ScriptingExtensions-Tests'
	'STON-Tests'
	'SUnit'
	'Spec-Tests'
	'System-Caching-Tests'
	'System-Hashing-Tests'
	'System-History-Tests'
	'System-Localization-Tests'
	'System-SessionManager-Tests'
	'System-Settings-Tests'
	'System-Support-Tests'
	'Text-Edition-Tests'
	'Tool-FileList-Tests'
	'Tools-Test'
	'Zinc-Resource-Meta-FileSystem'	
	'Zinc-Resource-Meta-Tests'
	'Zinc-HTTP-Examples'
	'Zinc-Tests'	"requires Zinc-Resource-Meta-Tests"
	'System-Identification-Tests'		
	'System-DependenciesTests'
	'System-BasicCommandLineHandler-Tests'
	'Transcript-NonInteractive-Tests'
	'PharoDocComment-Tests'	"standalone"
).	

spec group: 'FuzzyMatcher-Core-Group' with: #(
	'FuzzyMatcher'
).
spec group: 'FuzzyMatcher-Tests-Group' with: #(
	'FuzzyMatcher-Tests'
).
spec group: 'FuzzyMatcher-Group' with: #(
	'FuzzyMatcher-Core-Group'
	'FuzzyMatcher-Tests-Group'
).

spec group: 'Zodiac-Extras-Group' with: #(
	'Zodiac-Extra'
	'Zinc-Zodiac'
).
spec group: 'Zodiac-Tests-Group' with: #(
	'Zodiac-Tests'
).
spec group: 'Zodiac-Group' with: #(
	'Zodiac-Extras-Group'
	'Zodiac-Tests-Group'
).
spec group: 'ReflectionMirrors-Tests-Group' with: #(
	'ReflectionMirrors-Primitives-Tests'
).
spec group: 'ReflectionMirrors-Group' with: #(
	'ReflectionMirrors-Tests-Group'
).

spec group: 'Reflectivity-Group' with: #(
	'Reflectivity-Tests'	"required by Reflectivity-Examples"
	'Reflectivity-Examples'
).

spec group: 'SmartSuggestions-Core-Group' with: #(
	"depends on 'Glamour-Core-Group', circular dependency, needs fix"
	'SmartSuggestions'
).
spec group: 'SmartSuggestions-Tests-Group' with: #(
	'SmartSuggestions-Tests'
).
spec group: 'SmartSuggestions-Group' with: #(
	'SmartSuggestions-Core-Group'
	'SmartSuggestions-Tests-Group'
).

spec group: 'Manifest-Core-Group' with: #(
	'Manifest-Core'
).
spec group: 'Manifest-Tests-Group' with: #(
	'Kernel-Tests-Group' "dependency"
	'Manifest-Resources-Tests'
	'Manifest-Tests'	"depends on QA, needs cleanup"
).
spec group: 'Manifest-Group' with: #(
	'Manifest-Core-Group'
	'Manifest-Tests-Group'
).

spec group: 'BlueInk-Core-Group' with: #(
	'BlueInk-Core'
	'BlueInk-Extras'
).
spec group: 'BlueInk-Tests-Group' with: #(
	'Kernel-Tests-Group' "dependency"
	'BlueInk-Tests'	
).
spec group: 'BlueInk-Group' with: #(
	'BlueInk-Core-Group'
	'BlueInk-Tests-Group'
).

spec group: 'Shout-Core-Group' with: #(
	'Shout'		"'Polymorph-Widgets' and 'NECompletion' depend on it, fix needed?"
	'Rubric-Styling'	"requires 'Shout'"      
).
spec group: 'Shout-Tests-Group' with: #(
	'Shout-Tests'
).
spec group: 'Shout-Group' with: #(
	'Shout-Core-Group'
	'Shout-Tests-Group'
).

spec group: 'Metacello-Tests-Group' with: #(
	'Metacello-TestsMCResources'
	'Metacello-TestsCore'
	'Metacello-TestsCommonMC'
	'Metacello-TestsMC'	
	'Metacello-TestsMCCore'	
	'Metacello-TestsPlatform'	
	'Metacello-TestsReference'
	'Metacello-Gitlab-Tests'
).

spec group: 'Refactoring-Rules-Group' with: #(
	'QualityAssistant-Core-Group' "dependency"
	'SUnit-Rules'	
	'Kernel-Tests-Rules'
	'Polymorph-Widgets-Rules'
	'System-Settings-Rules'
	'System-Support-Rules'
	'Rubric-Rules'
).
spec group: 'Refactoring-Tests-Group' with: #(
	'Refactoring-Tests-Core'		"'Kernel-Tests' depend on it, cleanup needed!"
	'Refactoring-Tests-Changes'
	'Refactoring-Tests-Critics'
	'Refactoring-Tests-Environment'
).
spec group: 'Refactoring-Help-Group' with: #(
	'Refactoring-Help'

).
spec group: 'Refactoring-Group' with: #(
	'Refactoring-Rules-Group'
	'Refactoring-Tests-Group'
	'Refactoring-Help-Group' 
).
spec group: 'Catalog-Core-Group' with: #(
	'Glamour-Core-Group'	"dependency"
	'GT-Core-Group'	"dependency"
	'Tool-Catalog'
).

spec group: 'Catalog-Group' with: #(
	'Catalog-Core-Group'
).

spec group: 'SortFunctions-Group' with: #(
	'SortFunctions-Core'
	'SortFunctions-Tests'
).

spec group: 'ReferenceFinder-Group' with: #(
	'ReferenceFinder-Core'
).

spec group: 'QualityAssistant-Core-Group' with: #(
	"'Manifest-Tests' 'Polymorph-Widgets-Rules' depend on it, needs cleanup"
	'Manifest-Core-Group' "dependency"
	'Glamour-Core-Group'	"dependency"
	'DependencyAnalyser-Core-Group' "dependency"
	'GT-Core-Group'	"dependency"
	'Renraku'		
	'Tool-CriticBrowser'
).
spec group: 'QualityAssistant-Tests-Group' with: #(
	'Renraku-Test'
).
spec group: 'QualityAssistant-Help-Group' with: #(
	'Renraku-Help'
).
spec group: 'QualityAssistant-Group' with: #(
	'QualityAssistant-Core-Group'
	'QualityAssistant-Tests-Group'
	'QualityAssistant-Help-Group'
).

spec group: 'Glamour-Core-Group' with: #(
	'Shout-Core-Group'  "dependecy"
	"circular dependency on 'Glamour-Tests-Group', 'GT-Core-Group'"
	'Athens' "dependency"
	'Glamour-Announcements'
	'Glamour-Helpers'
	'Glamour-Core'
	'Glamour-Tasks'
	'Glamour-PagerModel'
	'Glamour-Presentations'
	'Glamour-Browsers'
	'Glamour-Morphic-Brick'
	'Glamour-Morphic-Theme'
	'Glamour-Morphic-Widgets'
	'Glamour-Morphic-Renderer'
	'Glamour-Morphic-Pager'
	'Glamour-Rubric-Presentations'	"requires Shout"
	'Glamour-FastTable'	
	'Glamour-SpecIntegration'
).
spec group: 'Glamour-Tests-Group' with: #(
	'Glamour-Tests-Core'
	'Glamour-Tests-Resources'
	'Glamour-Tests-Morphic'
	'Glamour-Morphic-Brick-Tests'
	'Glamour-Tests-Rubric'
).
spec group: 'Glamour-Group' with: #(
	'Glamour-Core-Group'
	'Glamour-Tests-Group'
).

spec group: 'GT-Core-Group' with: #(
	'SmartSuggestions-Group' "dependency"
	'Glamour-Core-Group'	"dependency"
	"'Morphic-Core' 'System-Settings' is dependent on this group, needs clenup"
	'OpalCompiler-Tools'
	'GT-Inspector'
	'GT-InspectorExtensions-Core'
	'GT-Playground'
	'GT-EventRecorder'
	'GT-Spotter'
	'GT-Spotter-UI'
	'GT-SpotterExtensions-Core'
	'GT-Debugger'
	'GT-BytecodeDebugger'
	'GT-SUnitDebugger'
).
spec group: 'GT-Tests-Group' with: #(
	'GT-Tests-Debugger'
	'GT-Tests-Inspector'
	'GT-Tests-Playground'
	'GT-Tests-Spotter'
).
spec group: 'GT-Group' with: #(
	'GT-Core-Group'
	'GT-Tests-Group'
).

spec group: 'DependencyAnalyser-Core-Group' with: #(
	'Manifest-Core-Group' "dependency"
	'Moose-Algos-Graph'
	'Tool-DependencyAnalyser'
	'Tool-DependencyAnalyser-UI'
).
spec group: 'DependencyAnalyser-Tests-Group' with: #(
	'Tool-DependencyAnalyser-Tests'	
	'Tool-DependencyAnalyser-Tests-Data'	
).
spec group: 'DependencyAnalyser-Group' with: #(
	'DependencyAnalyser-Core-Group'
	'DependencyAnalyser-Tests-Group'
).	

spec group: 'OSWindow-Core-Group' with: #(
	'Glamour-Core-Group'	"dependency, cleanup needed"
	'GT-Core-Group'	"dependency, cleanup needed"
	'Athens' "dependency"
	'OSWindow-Core'
	'OSWindow-SDL2'
	'OSWindow-VM'
	'OSWindow-SDL2-Examples'
).	
spec group: 'OSWindow-Tests-Group' with: #(
	'OSWindow-Tests'
).
spec group: 'OSWindow-Group' with: #(
	'OSWindow-Core-Group'
	'OSWindow-Tests-Group'
).

spec group: 'Kernel-Tests-Group' with: #(
	'BlueInk-Core-Group' "dependency"
	'RPackage-Tests'
	'CodeImport-Tests'	 
	'Collections-Tests'
	'Kernel-Tests' 
	'Kernel-Tests-Extended' 
	'Kernel-Tests-WithCompiler'
	'AST-Core-Tests' "requires BlueInk-Core"
	'Announcements-Core-Tests'
	'Compression-Tests' 
	'FileSystem-Tests-Core' 
	'FileSystem-Tests-Disk'
	'FileSystem-Tests-Memory'
	'FileSystem-Tests-Attributes'
	'Files-Tests' 
	'Jobs-Tests' 
	'Multilingual-Tests'
	'OpalCompiler-Tests' 
	'Random-Tests'
	"'ReleaseTests'"
	'Ring-Definitions-Tests-Core'
	'Ring-Definitions-Tests-Containers' 
	'Tests' 
	'System-Object Events-Tests'
	'System-OSEnvironments-Tests'
	'Zinc-Character-Encoding-Tests' 
	'System-Platforms-Tests'
	'Text-Tests'		"required by Multilingual-Tests"
).

spec group: 'Refactoring2-Group' with: #(
	'Refactoring2-Core'
	'Refactoring2-Transformations'
	'Refactoring2-Transformations-Tests'
).

spec group: 'GT&QA-Group' with: #(
	'GeneralRules'		"depends on QA, needs cleanup"
	'GeneralRules-Tests' "depends on QA, needs cleanup"
	'Kernel-Rules'		"depends on QA, DependencyAnalyzer, needs cleanup"

	'ReleaseTests' 		"required by Manifest-Core Refactoring-Critics"
	'Reflectivity-Tools'	"required by Manifest-Core Refactoring-Critics"

	'NautilusRefactoring'	"required by Epicea, SmartSuggestions"
	'NautilusRefactoring-Tests'
	'Refactoring-Critics'	"depends on QA, needs cleanup"

	'Glamour-Group'
	'GT-Group'

	'Manifest-Group'
	'DependencyAnalyser-Group'
	'QualityAssistant-Group'
	'Reflectivity-Group'
).		

spec group: 'UndefinedClasses-Group' with: #(
	'ClassParser'
	'ClassParser-Tests'
	'UndefinedClasses'
	'UndefinedClasses-Tests'
).		

spec group: #default with: #(
	'BasicTools'	"dependency"
	'Athens'
	'Flashback'
	'Clap'
	
	'Mandatory-Group'

	'Kernel-Tests-Group'
	'BlueInk-Group'

	'Shout-Group'

	"standalone:" 
	'Metacello-Tests-Group'		 
	'General-Help-Group'
	'ReflectionMirrors-Group'
	'Zodiac-Group'
	'FuzzyMatcher-Group'

	'GT&QA-Group'

	"standalone but dependent:"
	'OSWindow-Group'
	'Refactoring-Group'
	'Catalog-Group'
	'Epicea-Group'
	'Optional-Group'
	'General-Tests-Group'
	'SortFunctions-Group'	
	'ReferenceFinder-Group'
	
	'BaselineOfPharoBootstrap'
	'BaselineOfMonticello'
	'BaselineOfMetacello'
	'BaselineOfTelePharoSupport'
	
	"Importing tests of Shift"
	'Shift'
	"Importing tests of Traits"
	'Traits'
	'Slot'
	
	'Refactoring2-Group'
	'UndefinedClasses-Group'
	
	'Calypso'
	'Ring'
).

]

{ #category : #actions }
BaselineOfIDE >> loadIceberg [
	Metacello new
		baseline: 'Iceberg';
		repository: 'github://pharo-vcs/iceberg:v1.6.2';
		onConflictUseLoaded;
		load.
	(Smalltalk classNamed: #Iceberg) enableMetacelloIntegration: true.
	(Smalltalk classNamed: #IcePharoPlugin) addPharoProjectToIceberg.
]

{ #category : #actions }
BaselineOfIDE >> makeCalypsoDefaultBrowser [

	(self class environment at: #ClyBrowserMorph) beAllDefault.
]

{ #category : #actions }
BaselineOfIDE >> postload: loader package: packageSpec [

	| initializersEnabled repo gofer |

	"Ignore pre and post loads if already executed"
	Initialized = true ifTrue: [ ^ self ].

	Author fullName: self class name.
	
	"collect and process the standard tools registrations"
	Smalltalk tools initDefaultToolSet.
	
	initializersEnabled := MCMethodDefinition initializersEnabled.

	MCMethodDefinition initializersEnabled: false.
	
	repo := TonelRepository new
		directory: self packageRepository directory;
		yourself.
		
	gofer := Gofer it repository: repo.
	gofer package: #'RPackage-Tests'.
	gofer load.
	
	MCMethodDefinition initializersEnabled: initializersEnabled.
	
	Smalltalk tools register: GTGenericStackDebugger as: #debugger.	

	Smalltalk cleanOutUndeclared. 

	Stdio stdout 
		nextPutAll: ' ------------ Obsolete ------------';
		lf;
		nextPutAll: SystemNavigation default obsoleteClasses asString;
		lf;
		nextPutAll: ' ............ Obsolete ............';
		lf.

	Smalltalk fixObsoleteReferences.
	
	EpMonitor current enable.
		
	Author reset.

	MCMethodDefinition initializersEnabled: initializersEnabled.
	
	self additionalInitialization.

	Initialized := true.
]
