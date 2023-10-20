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

    operation RandomNumberInRange(min: Int, max: Int): Int{
        mutable output = 0;
        repeat{
            mutable bits = [];
            for idxBit in 1..BitSizeI(max){
                set bits += [GenerateRandomBit()];
            }
            set output = ResultArrayAsInt(bits);
        }
        until(output <= max and output >= min);

        return output;
    }

    @EntryPoint()
    operation SampleRNG(): Int{
        let max = 50;
        let min = 11;
        Message($"RNG of num between {min} and {max}");
        return RandomNumberInRange(min, max);
    }
}
