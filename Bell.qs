namespace Quantum.Bell {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    operation Set(attendue: Result, q1: Qubit) : Unit {
        let courante = M(q1);

        if(attendue != courante) {
            X(q1);
        }
    }

    operation BellTest(nombre: Int, debut: Result) : (Int, Int, Int) {
        mutable numOnes = 0;
        mutable accord = 0;

        use qubits = Qubit[2];

        for test in 1..nombre {
            Set(debut, qubits[0]);
            Set(Zero, qubits[1]);

            H(qubits[0]);
            CNOT(qubits[0], qubits[1]);

            let res = M(qubits[0]);

            if(M(qubits[1]) == res) {
                set accord += 1;
            }

            if(res == One) {
                set numOnes += 1;
            }
        }

        Set(Zero, qubits[0]);
        Set(Zero, qubits[1]);

        return (nombre - numOnes, numOnes, accord);
    }
    
}

