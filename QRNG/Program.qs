namespace QRNG {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    operation GenerateRandomBit(): Result{
        //allocate qbit
        use q = Qubit();

        //put qbit to superposition
        H(q);

        //measure qbit value
        return M(q);
    }

    operation RandomNumberInRange(max: Int): Int{
        mutable output = 0;
        repeat{
            mutable bits = [];
            for idxBit in 1..BitSizeI(max){
                set bits += [GenerateRandomBit()];
            }
            set output = ResultArrayAsInt(bits);
        }
        until(output <= max);

        return output;
    }

    @EntryPoint()
    operation SampleRNG():Int{
        let max = 50;
        Message($"RNG of num between 0 and {max}");
        return RandomNumberInRange(max);
    }
}
