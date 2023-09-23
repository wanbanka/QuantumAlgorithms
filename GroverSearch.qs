namespace Grover {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    operation RunGroversSearch(
        register : Qubit[], 
        phaseOracle: ((Qubit[]) => Unit is Adj), 
        iterations: Int) : Unit {
            ApplyToEach(H, register);

            for _ in 1 .. iterations {
                phaseOracle(register);

                within {
                    ApplyToEachA(H, register);
                    ApplyToEachA(X, register);
                } apply {
                    //Most: exclut le dernier élément d'un tableau
                    //Tail: récupère le dernier élément d'un tableau
                    Controlled Z(Most(register), Tail(register));
                }
            }
    }
}