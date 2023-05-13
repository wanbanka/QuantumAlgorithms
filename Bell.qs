namespace Quantum.Bell {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    operation Set(attendue: Result, q1: Qubit) : Unit {
        let courante = M(q1);

        if(attendue != courante) {
            X(q1);
        }
    }

    operation BellTest(nombre: Int, debut: Result) : (Int, Int) {
        mutable numOnes = 0;

        use qubit = Qubit();

        for test in 1..nombre {
            Set(debut, qubit);

            let res = M(qubit);

            if(res == One) {
                set numOnes += 1;
            }
        }

        Set(Zero, qubit);

        Reset(qubit);

        return (nombre - numOnes, numOnes);
    }
    
}

