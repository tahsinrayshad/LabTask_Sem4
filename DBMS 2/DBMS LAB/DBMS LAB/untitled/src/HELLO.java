import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class HELLO extends JFrame{
    private JPanel panelMain;
    private JLabel nameLabel;
    private JTextField txtname;
    private JButton clickButton;

    private void createUIComponents() {
        // TODO: place custom component creation code here
    }

    public HELLO()
    {
        clickButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JOptionPane.showMessageDialog(clickButton,txtname.getText()+" HELLO ");
            }
        });
    }


    public static void main(String[] args) {

        HELLO h = new HELLO();

        h.setContentPane(h.panelMain);
        h.setContentPane(h.panelMain);

        h.setTitle("HIGNESH");
        h.setSize(300,400);

        h.setVisible(true);
        h.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);


    }
}
