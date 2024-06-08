public class C1 {
    public static void main(String[] args) {
        C1 ob1 = new C1();
        Object ob2 = ob1;
        System.out.println(ob2 instanceof Object);
        System.out.println(ob2 instanceof C1);
    }
}
