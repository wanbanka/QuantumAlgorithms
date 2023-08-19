namespace Grover {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    operation MarkColorEquality(c0: Qubit[], c1: Qubit[], target: Qubit): Unit is Adj+Ctl {
        
        //Within-Apply: conjugaison. Permet de libérer la mémoire et 
        //de faire un calcul inverse pour se retrouver dans l'état initial
        within {
            for (q0, q1) in Zipped(c0, c1) {
                CNOT(q0, q1);
            }
        } apply {
            //ControlledOnInt: opération itérative vérifiant
            //si toutes les valeurs du tableau c1 valent 0, et si oui,
            //applique une porte quantique au qubit cible
            (ControlledOnInt(0, X))(c1, target);
        }
    }

    operation MarkValidvertexColoring(
        edges: (Int, Int)[],
        colorsRegister: Qubit[],
        target: Qubit
    ) : Unit is Adj+Ctl {
        let nEdges = Length(edges);

        let colors = Chunks(2, colorsRegister);

        use conflictQubits = Qubit[nEdges];

        within {
            for ((start, end), conflictQubit) in Zipped(edges, conflictQubits) {
                MarkColorEquality(colors[start], colors[end], conflictQubit);
            }
        } apply {
            (ControlledOnInt(0, X))(conflictQubits, target);
        }
    }

    operation ApplyMarkingOracleAsPhaseOracle(
        markingOracle: ((Qubit[], Qubit[], Qubit) => Unit is Adj),
        c0: Qubit[],
        c1: Qubit[]
    ) : Unit is Adj {
        use target = Qubit();

        within {
            X(target);
            H(target);
        } apply {
            markingOracle(c0, c1, target);
        }
    }

    operation ShowColorEqualityCheck() : Unit {
        use (c0, c1, target) = (Qubit[2], Qubit[2], Qubit());

        ApplyToEach(H, c1);

        Message("Start state : ");
        DumpRegister((), c1 + [target]);

        MarkColorEquality(c0, c1, target);

        Message("");
        Message("After equality check:");
        DumpRegister((), c1 + [target]);

        ResetAll(c1 + [target]);
    }

    @EntryPoint()
    operation ShowPhaseKickbackTrick() : Unit {
        use (c0, c1) = (Qubit[2], Qubit[2]);

        ApplyToEach(H, c1);

        Message("Starting state: ");
        DumpRegister((), c1);

        ApplyMarkingOracleAsPhaseOracle(MarkColorEquality, c0, c1);

        Message("");
        Message("After check: ");

        DumpRegister((), c1);

        ResetAll(c1);
    }
}