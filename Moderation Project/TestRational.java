/*
  Beginning of class to test the Rational ADT implementation.
*/
public class TestRational {
    public static void test(String s, Object obj) {
	System.out.println(s + "\t\t" + obj);
    }
    
    public static void main(String args[]) {
	Rational r = null;
	Rational R1 = new Rational(36,-24);
	Rational R2 = new Rational(6,8);
	Rational R3 = new Rational(1,-5);
	Rational R4 = new Rational(0,5);
	Rational R5 = new Rational(-3,2);
		
	
	try {
	    // try making a bad rational
	    r = new Rational(10,0);
	}
	catch (Exception exp) {
	    System.out.println(exp.toString());
	}

	// Implicitly uses toString method of Object class.
	test("Correct","Actual");
	test("-3/2" , R1);
	test("-7/5" , new Rational(35,-25));
	test("false" , R4.equals(R1));

	test("true" , R1 == R1);
	test("true" , R1.equals(R1));
	test("false" , R1 == R5);  // Note difference with next line!
	test("true" , R1.equals(R5));

	
	// TODO: Comment in AND add more tests!!
	//test("false" , R2.gt(R2));
	//test("true" , R2.gt(R3));
	//test("11/20" , Rational.add(R2,R3));

    }


}
