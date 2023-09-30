///@source https://learn.microsoft.com/fr-fr/training/modules/solve-graph-coloring-problems-grovers-search/4-implement-quantum-oracle

namespace Grover {

    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    
    @EntryPoint()
    operation SolveGraphColoringProblem() : Unit {
        let nVertices = 5;

        let edges = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4)];

        //Dans une opération, on peut mettre en paramètre
        //_, signifiant une application partielle (on peut rappler la même
        //opération avec moins de paramètres, un des paramètres étant fixé)

        let markingOracle = MarkValidvertexColoring(edges, _, _);
        let phaseOracle = ApplyMarkingOracleAsPhaseOracle(markingOracle, _);

        let nQubits = 2 * nVertices;

        //Nombre de chaînes de bits de longueur nQubits

        let searchSpaceSize = 2 ^ (nQubits);

        //Nombre de solutions possibles: permutations des quatre premiers
        //sommets (4!), mutliplié par 3 (nombre de couleurs que peut prendre
        //le cinquième et dernier sommet)

        let nSolutions = 72;

        Message($"Length of bit string: {nQubits} qubits");

        Message($"Number of strings: {searchSpaceSize} strings");

        let nIterations = Round(PI() / 4.0 * Sqrt(IntAsDouble(searchSpaceSize) / IntAsDouble(nSolutions)));

        Message($"Iterations: {nIterations}");

        mutable answer = [];

        use (register, output) = (Qubit[nQubits], Qubit());

        mutable isCorrect = false;

        Message("Loading...");

        repeat {
            RunGroversSearch(register, phaseOracle, nIterations);

            //MultiM: mesure tous les qubits d'un registre et renvoie un
            //tableau de résultats
            let res = MultiM(register);

            Message($"Result : {res}");

            //Vérifie si la coloration du graphe est bonne

            markingOracle(register, output);

            if(MResetZ(output) == One) {
                set isCorrect = true;
                //ResultArrayAsBoolArray: convert un tableau de Result 
                //en tableau de booléens (One équivaut à true, Zero à false)
                set answer = ResultArrayAsBoolArray(res);
            }

            ResetAll(register);
        } until(isCorrect);

        let colorBits = Chunks(2, answer);

        Message($"Color Bits: {colorBits}");

        Message("The resulting graph coloring: ");

        for i in 0 .. nVertices - 1 {
            Message($"Vertex {i} : color {BoolArrayAsInt(colorBits[i])}");
        }

        // //Transforme un tableau de booléens en tableau de qubits
        // // (false = |0>, true = |1>)
        // ApplyPauliFromBitString(PauliX, true, coloring, coloringRegister);
    }
}

