package com.company;
import java.math.BigInteger;

/**
 This class provides common arithmetic operations for a rational
 numbers (integer numerator and denominator) ADT.

 All rational numbers are maintained in lowest terms, with a
 denominator that is a positive integer.

 @see java.lang.Object
 @author CHI NGUYEN
 @date February 2019
 */


public class Rational {
    private BigInteger denB,numB,gcd;
    /**
     Default constructor initializes rational to 0.
     */
    public Rational() {
        //BIGINT
        denB = new BigInteger("1");
        numB = new BigInteger("0");
    }

    /**
     <code>Rational</code> constructor
     @param numB the numerator
     @param denB the denominator
     @throws NumberFormatException if den is zero
     */
    public Rational(BigInteger numB, BigInteger denB) {
        if (denB.compareTo(new BigInteger("0")) == 0)
            throw new NumberFormatException("Rational cannot have zero denominator.");
        this.numB= numB;
        this.denB = denB;
        // if rational is negative then the "-" would be placed at the num or both num and den are negative then the rational is positive
        if(this.denB.compareTo(new BigInteger("0")) == -1){
            this.numB = this.numB.multiply(new BigInteger("-1"));
            this.denB = this.denB.multiply(new BigInteger("-1"));
        }
        //reduce to the final form of the rational
        //gcd = GCD(this.numB,this.denB);
        gcd = this.numB.gcd(this.denB);
        this.numB = this.numB.divide(gcd);
        this.denB = this.denB.divide(gcd);
    }

    /**
     private function GCD, not provided to clients
     finds the greatest common divisor of M and N
     Pre: M and N are defined
     Post: returns the GCD of M and N, by Euclid's Algorithm
     */
    private BigInteger GCD(BigInteger m, BigInteger n) {
        BigInteger r = m.mod(n);
        if(r.compareTo(new BigInteger("0")) == 0) return n;
        return GCD(n,r);
    }

    /**
     @param R a rational
     @return true iff rational object < R.
     */

    public boolean lt(Rational R) {
        BigInteger temp1 = numB.multiply(R.denB);
        BigInteger temp2 = denB.multiply(R.numB);
        if (temp1.compareTo(temp2)==-1){
            return true;
        } else return false;
    }

    /**
     @param R a rational
     @return true iff rational object = R.
     */
    public boolean equals(Rational R) {
        int temp1 =numB.compareTo(R.numB);
        int temp2 = denB.compareTo(R.denB);
        if(temp1 ==0 && temp2==0){
            return true;
        } else return false;
    }

    /**
     @param R a rational
     @return true iff rational object > R.
     */
    public boolean gt(Rational R) {
        BigInteger temp1 = numB.multiply(R.denB);
        BigInteger temp2 = denB.multiply(R.numB);
        if (temp1.compareTo(temp2)==1){
            return true;
        } else return false;
    }

    /**
     @param r
     @param s
     @return Rational corresponding to sum of r + s.
     */
    public static Rational add(Rational r, Rational s) {
        BigInteger addDEN = r.denB.multiply(s.denB);
        BigInteger temp1 =r.numB.multiply(s.denB);
        BigInteger temp2 = s.numB.multiply(r.denB);
        BigInteger addNUM = temp1.add(temp2);
        return new Rational(addNUM,addDEN);
    }

    /**
     @param r
     @param s
     @return Rational corresponding to substraction of r - s.
     */
    public static Rational subtract(Rational r, Rational s) {
        BigInteger subDEN = r.denB.multiply(s.denB);
        BigInteger temp1 =r.numB.multiply(s.denB);
        BigInteger temp2 = s.numB.multiply(r.denB);
        BigInteger subNUM =  temp1.subtract(temp2);
        return new Rational(subNUM,subDEN);
    }

    /**
     @param r
     @param s
     @return Rational corresponding to multiplication of r * s.
     */
    public static Rational multiply(Rational r, Rational s) {
        BigInteger mulDEN = r.denB.multiply(s.denB);
        BigInteger mulNUM = r.numB.multiply(s.numB);
        return new Rational(mulNUM,mulDEN);
    }

    /**
     @param r
     @param s
     @return Rational corresponding to division of r / s.
     */
    public static Rational divide(Rational r, Rational s) {
        BigInteger divDEN = r.numB.multiply(s.denB);
        BigInteger divNUM = r.denB.multiply(s.numB);
        return new Rational(divNUM,divDEN);
    }
    /**
     @param r (Rational)
     @param s (BigInt)
     @return Rational corresponding to r ^ s ( r to the power of s).
     */
    public static Rational tothepowerof(Rational r, int s) {
        BigInteger powDEN = r.denB.pow(s);
        BigInteger powNUM = r.numB.pow(s);
        return new Rational(powNUM,powDEN);
    }

    /**
     Convert to String in standard format (i.e., numerator/denominator)
     @ return a <code>String</code> representation of
     the item.
     */
    public String toString() {
        return new String (num+"/"+den);
    }


}  // end of Rational class
