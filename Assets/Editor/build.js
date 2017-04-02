import System.Diagnostics;

class Autobuild {

    static function Build() {
        // Get filename.
        var path = "App";
        var commandLineArgs = System.Environment.GetCommandLineArgs();
        // First command line argument is the name of this Function
        var scenes : String[] = commandLineArgs.splice(0, 1);
        
        // Build player.
        BuildPipeline.BuildPlayer(scenes, path, BuildTarget.WSAPlayer, BuildOptions.None);
    }
}