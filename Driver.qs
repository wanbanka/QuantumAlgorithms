namespace Quantum.Bell  {

    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation run() : Unit {

        let initials = [Zero, One];

        for idx in 0..Length(initials) - 1 {
            let res = BellTest(1000, initials[idx]);

            let (numZeros, numOnes) = res;

            Message($"Init:{initials[idx]} 0s={numZeros} 1s={numOnes}");
        }

    }

}