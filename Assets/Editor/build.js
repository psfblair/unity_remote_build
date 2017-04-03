import System.Diagnostics;
import System.Collections.Generic;

class Autobuild {

    static function Build() {
        // Get filename.
        var path = "App";

        // These are all the command line arguments to Unity.exe
        var commandLineArgs = System.Environment.GetCommandLineArgs();

        // We want everything after "-executeMethod Autobuild.Build"
        var scenes = new List.<String>();
        var isAfterAutobuild = false;
        
        for (i=1; i < commandLineArgs.length; i++) {
            if (isAfterAutobuild) {
                scenes.Add(commandLineArgs[i]);
            }
            if (commandLineArgs[i] == "Autobuild.Build") {
                isAfterAutobuild = true;
            }
        }
        
        // Build player.
        BuildPipeline.BuildPlayer(scenes.ToArray(), path, BuildTarget.WSAPlayer, BuildOptions.None);
    }
}