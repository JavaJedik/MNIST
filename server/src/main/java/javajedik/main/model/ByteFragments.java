package javajedik.main.model;

import java.util.Arrays;

public class ByteFragments 
{
    private final byte[][] fragments;
    private final int lastFragmentValidLength;

    public ByteFragments(byte[] data, int fragmentLength) 
    {
        int length = data.length;
        int numOfChunks = (int) Math.ceil((double) length / fragmentLength);
        fragments = new byte[numOfChunks][];

        for (int i = 0; i < numOfChunks; i++) 
        {
            int start = i * fragmentLength;
            int end = start + fragmentLength;
            fragments[i] = new byte[fragmentLength];
            if (end > length) 
            {
                Arrays.fill(fragments[i], 0, length % fragmentLength, (byte) 0);
                System.arraycopy(data, start, fragments[i], 0, length % fragmentLength);
            } else 
            {
                System.arraycopy(data, start, fragments[i], 0, fragmentLength);
            }
        }

        lastFragmentValidLength = fragmentLength;
    }

    public byte[][] getFragments() 
    {
        return fragments;
    }

    public int getLastFragmentValidLength() 
    {
        return lastFragmentValidLength;
    }
}