///@source https://learn.microsoft.com/fr-fr/training/modules/solve-graph-coloring-problems-grovers-search/4-implement-quantum-oracle

namespace Grover {

    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    
    
    operation SolveGraphColoringProblem() : Unit {
        let nVertices = 5;

        let edges = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4)];

        let coloring = [false, false, true, false, false, true, true, true, true, false];

        use (coloringRegister, target) = (Qubit[2 * nVertices], Qubit());

        //Transforme un tableau de booléens en tableau de qubits
        // (false = |0>, true = |1>)
        ApplyPauliFromBitString(PauliX, true, coloring, coloringRegister);

        MarkValidvertexColoring(edges, coloringRegister, target);

        let isColoringValid = M(target) == One;

        Message($"The coloring is {isColoringValid ? "valid" | "invalid"}");

        ResetAll(coloringRegister);
    }
}

