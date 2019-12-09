package main;

import java.awt.EventQueue;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;








public class PopUp
{
  private JFrame frame;
  
  public static void main(final String[] args) {
    EventQueue.invokeLater(new Runnable() {
          public void run() {
            try {
              PopUp window = new PopUp(args);
              window.frame.setVisible(true);
            } catch (Exception e) {
              e.printStackTrace();
            } 
          }
        });
  }





  
  public PopUp(String[] args) { initialize(args); }





  
  private void initialize(String[] args) {
    try {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    } catch (ClassNotFoundException e) {
      
      e.printStackTrace();
    } catch (InstantiationException e) {
      
      e.printStackTrace();
    } catch (IllegalAccessException e) {
      
      e.printStackTrace();
    } catch (UnsupportedLookAndFeelException e) {
      
      e.printStackTrace();
    } 
    this.frame = new JFrame();
    this.frame.setBounds(100, 100, 240, 76);
    this.frame.setDefaultCloseOperation(2);
    this.frame.getContentPane().setLayout(null);
    this.frame.setTitle(args[0]);
    this.frame.setResizable(false);
    this.frame.setAlwaysOnTop(true);
    this.frame.setLocation(Integer.valueOf(args[2]).intValue(), Integer.valueOf(args[3]).intValue());
    
    JLabel lblNull = new JLabel(args[1]);
    lblNull.setBounds(10, 11, 164, 14);
    this.frame.getContentPane().add(lblNull);
  }
}
