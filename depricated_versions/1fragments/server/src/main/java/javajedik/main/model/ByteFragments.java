package javajedik.main.model;

import java.util.Arrays;
import org.checkerframework.checker.units.qual.Length;

public class ByteFragments 
{
    private final byte[][] fragments;
    private final int lastFragmentValidLength;
    private final int numberOfFragments;

    public ByteFragments(byte[] data, int fragmentLength) 
    {
        int length = data.length;
        numberOfFragments = (int) Math.ceil((double) length / fragmentLength);
        fragments = new byte[numberOfFragments][];

        for (int i = 0; i < numberOfFragments; i++) 
        {
            int start = i * fragmentLength;
            int end = start + fragmentLength;
            fragments[i] = new byte[fragmentLength];
            if (end > length - 1) 
            {
                System.arraycopy(data, start, fragments[i], 0, length % fragmentLength);
            } else 
            {
                System.arraycopy(data, start, fragments[i], 0, fragmentLength);
            }
        }

        lastFragmentValidLength = length % fragmentLength;
    }

    public byte[][] getFragments() 
    {
        return fragments;
    }
    
    public byte[] getNthFragment(int fragmentId)
    {
        return fragments[fragmentId];
    }
    
    public int getNumberOfFragments()
    {
        return numberOfFragments;
    }

    public int getLastFragmentValidLength() 
    {
        return lastFragmentValidLength;
    }
}