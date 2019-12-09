package main;

import java.awt.Desktop;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JSeparator;
import javax.swing.JTabbedPane;
import javax.swing.JTextField;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;






















public class Main
{
  private JFrame frame;
  private static JTextField textChampName;
  private static JTextField textSpeedQ;
  private static JTextField textDelayQ;
  private static JTextField textRangeQ;
  private static JTextField textWidthQ;
  private static JTextField textSpeedW;
  private static JTextField textDelayW;
  private static JTextField textRangeW;
  private static JTextField textWidthW;
  private static JTextField textSpeedE;
  private static JTextField textDelayE;
  private static JTextField textRangeE;
  private static JTextField textWidthE;
  private static JTextField textSpeedR;
  private static JTextField textDelayR;
  private static JTextField textRangeR;
  private static JTextField textWidthR;
  private static JTextField textCreator;
  private static JTabbedPane tabbedPane;
  private static JButton btnGenerateScript;
  private static JPanel general;
  private static JCheckBox chckbxTargetMinionsR;
  private static JCheckBox chckbxUseInComboR;
  private static JCheckBox chckbxUseInHarrasR;
  private static JCheckBox chckbxUseInLasthitR;
  private static JCheckBox chckbxUseInLaneclearR;
  private static JLabel lblTypeR;
  private static JComboBox comboBoxR;
  private static JCheckBox chckbxAoeR;
  private static JCheckBox chckbxCollisionR;
  private static JLabel lblWidthR;
  private static JLabel lblRangeR;
  private static JLabel lblDelayR;
  private static JLabel lblSpeedR;
  private static JCheckBox chckbxTargetJungleR;
  private static JSeparator separator_1r;
  private static JSeparator separatorR;
  private static JCheckBox chckbxIsSkillshotR;
  private static JCheckBox chckbxTargetSelfR;
  private static JCheckBox chckbxTargetAllysR;
  private static JCheckBox chckbxTargetEnemysR;
  private static JPanel r;
  private static JCheckBox chckbxTargetMinionsE;
  private static JCheckBox chckbxUseInComboE;
  private static JCheckBox chckbxUseInHarrasE;
  private static JCheckBox chckbxUseInLasthitE;
  private static JCheckBox chckbxUseInLaneclearE;
  private static JLabel lblTypeE;
  private static JComboBox comboBoxE;
  private static JCheckBox chckbxAoeE;
  private static JLabel lblWidthE;
  private static JLabel lblRangeE;
  private static JLabel lblDelayE;
  private static JLabel lblSpeedE;
  private static JCheckBox chckbxTargetJungleE;
  private static JSeparator separator_1e;
  private static JSeparator separatorE;
  private static JCheckBox chckbxIsSkillshotE;
  private static JCheckBox chckbxTargetSelfE;
  private static JCheckBox chckbxTargetAllysE;
  private static JCheckBox chckbxTargetEnemysE;
  private static JPanel e;
  private static JCheckBox chckbxTargetMinionsW;
  private static JCheckBox chckbxUseInComboW;
  private static JCheckBox chckbxUseInHarrasW;
  private static JCheckBox chckbxUseInLasthitW;
  private static JCheckBox chckbxUseInLaneclearW;
  private static JLabel lblTypeW;
  private static JComboBox comboBoxW;
  private static JCheckBox chckbxAoeW;
  private static JCheckBox chckbxCollisionW;
  private static JLabel lblWidthW;
  private static JLabel lblRangeW;
  private static JLabel lblDelayW;
  private static JLabel lblSpeedW;
  private static JCheckBox chckbxTargetJungleW;
  private static JSeparator separator_1w;
  private static JSeparator separatorW;
  private static JCheckBox chckbxIsSkillshotW;
  private static JCheckBox chckbxTargetSelfW;
  private static JCheckBox chckbxTargetAllysW;
  private static JCheckBox chckbxTargetEnemysW;
  private static JPanel w;
  private static JCheckBox chckbxTargetMinionsQ;
  private static JCheckBox chckbxUseInComboQ;
  private static JCheckBox chckbxUseInHarrasQ;
  private static JCheckBox chckbxUseInLasthitQ;
  private static JCheckBox chckbxUseInLaneclearQ;
  private static JLabel lblTypeQ;
  private static JComboBox comboBoxQ;
  private static JCheckBox chckbxAoeQ;
  private static JCheckBox chckbxCollisionQ;
  private static JLabel lblWidthQ;
  private static JLabel lblRangeQ;
  private static JLabel lblDelayQ;
  private static JLabel lblSpeedQ;
  private static JCheckBox chckbxTargetJungleQ;
  private static JSeparator separator_1q;
  private static JSeparator separatorQ;
  private static JCheckBox chckbxIsSkillshotQ;
  private static JCheckBox chckbxTargetSelfQ;
  private static JCheckBox chckbxTargetAllysQ;
  private static JCheckBox chckbxTargetEnemysQ;
  private static JPanel q;
  private static JLabel lblYourName;
  private static JLabel lblChampion;
  private static JProgressBar progressBar;
  private static JCheckBox chckbxCollisionE;
  private static JTextField textMinRangeQ;
  private static JTextField textDmgFormQ;
  private JLabel lblMinimumDistanceToQ;
  private static JCheckBox chckbxResetAaQ;
  private JLabel lblDamageFormularQ;
  private static JCheckBox chckbxAutokillStealQ;
  private static JTextField textMinRangeW;
  private static JTextField textDmgFormW;
  private JLabel lblMinimumDistanceToW;
  private static JCheckBox chckbxResetAaW;
  private JLabel lblDamageFormularW;
  private static JCheckBox chckbxAutokillStealW;
  private static JTextField textMinRangeE;
  private static JTextField textDmgFormE;
  private JLabel lblMinimumDistanceToE;
  private static JCheckBox chckbxResetAaE;
  private JLabel lblDamageFormularE;
  private static JCheckBox chckbxAutokillStealE;
  private static JTextField textMinRangeR;
  private static JTextField textDmgFormR;
  private JLabel lblMinimumDistanceToR;
  private static JCheckBox chckbxResetAaR;
  private JLabel lblDamageFormularR;
  private static JCheckBox chckbxAutokillStealR;
  private JCheckBox chckbxOpenScriptAfter;
  
  public static void main(String[] args) {
    EventQueue.invokeLater(new Runnable()
        {
          public void run() {
            try {
              Main window = new Main();
              window.frame.setVisible(true);
            } catch (Exception e) {
              e.printStackTrace();
            } 
          }
        });
  }




  
  public Main() { initialize(); }



  
  public void initialize()
  {
    try {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    } catch (ClassNotFoundException e) {
      String[] error = new String[4];
      error[0] = "Exception 1";
      error[1] = "ClassNotFoundException";
      error[2] = String.valueOf(btnGenerateScript.getX());
      error[3] = String.valueOf(btnGenerateScript.getY());
      PopUp.main(error);
      e.printStackTrace();
    } catch (InstantiationException e) {
      String[] error = new String[4];
      error[0] = "Exception 2";
      error[1] = "InstantiationException";
      error[2] = String.valueOf(btnGenerateScript.getX());
      error[3] = String.valueOf(btnGenerateScript.getY());
      PopUp.main(error);
      e.printStackTrace();
    } catch (IllegalAccessException e) {
      String[] error = new String[4];
      error[0] = "Exception 3";
      error[1] = "IllegalAccessException";
      error[2] = String.valueOf(btnGenerateScript.getX());
      error[3] = String.valueOf(btnGenerateScript.getY());
      PopUp.main(error);
      e.printStackTrace();
    } catch (UnsupportedLookAndFeelException e) {
      String[] error = new String[4];
      error[0] = "Exception 4";
      error[1] = "UnsupportedLookAndFeelException";
      error[2] = String.valueOf(btnGenerateScript.getX());
      error[3] = String.valueOf(btnGenerateScript.getY());
      PopUp.main(error);
      e.printStackTrace();
    } 
    this.frame = new JFrame();
    this.frame.setResizable(false);
    this.frame.setBounds(100, 100, 650, 450);
    this.frame.setDefaultCloseOperation(3);
    this.frame.setTitle("QWER-Generator by S1mple 1.1");
    this.frame.getContentPane().setLayout(null);

    
    tabbedPane = new JTabbedPane(1);
    tabbedPane.setBounds(0, 0, 644, 421);
    this.frame.getContentPane().add(tabbedPane);
    
    general = new JPanel();
    tabbedPane.addTab("General", null, general, null);
    general.setLayout(null);
    
    btnGenerateScript = new JButton("Generate Script");
    btnGenerateScript.setBounds(170, 330, 300, 30);
    general.add(btnGenerateScript);
    
    progressBar = new JProgressBar();
    progressBar.setBounds(10, 368, 613, 14);
    general.add(progressBar);
    
    lblChampion = new JLabel("Champion Name:");
    lblChampion.setBounds(10, 11, 89, 14);
    general.add(lblChampion);
    
    textChampName = new JTextField();
    textChampName.setText("Syndra");
    textChampName.setBounds(100, 8, 115, 20);
    general.add(textChampName);
    textChampName.setColumns(10);
    
    textCreator = new JTextField();
    textCreator.setText("S1mple");
    textCreator.setBounds(100, 36, 115, 20);
    general.add(textCreator);
    textCreator.setColumns(10);
    
    lblYourName = new JLabel("Your Name:");
    lblYourName.setBounds(10, 39, 80, 14);
    general.add(lblYourName);
    
    this.chckbxOpenScriptAfter = new JCheckBox("Open Script after Generation (Default .lua File Editor)");
    this.chckbxOpenScriptAfter.setSelected(true);
    this.chckbxOpenScriptAfter.setBounds(10, 63, 281, 23);
    general.add(this.chckbxOpenScriptAfter);
    
    q = new JPanel();
    tabbedPane.addTab("Q", null, q, null);
    q.setLayout(null);
    
    chckbxTargetEnemysQ = new JCheckBox("Target Enemy's");
    chckbxTargetEnemysQ.setBounds(6, 7, 121, 23);
    q.add(chckbxTargetEnemysQ);
    
    chckbxTargetAllysQ = new JCheckBox("Target Ally's");
    chckbxTargetAllysQ.setBounds(6, 33, 121, 23);
    q.add(chckbxTargetAllysQ);
    
    chckbxTargetSelfQ = new JCheckBox("Target Self");
    chckbxTargetSelfQ.setBounds(6, 59, 121, 23);
    q.add(chckbxTargetSelfQ);
    
    chckbxIsSkillshotQ = new JCheckBox("Is Skillshot");
    chckbxIsSkillshotQ.setBounds(204, 7, 75, 23);
    q.add(chckbxIsSkillshotQ);
    
    separatorQ = new JSeparator();
    separatorQ.setBounds(0, 115, 640, 2);
    q.add(separatorQ);
    
    separator_1q = new JSeparator();
    separator_1q.setBounds(0, 120, 640, 2);
    q.add(separator_1q);
    
    chckbxTargetJungleQ = new JCheckBox("Target Jungle");
    chckbxTargetJungleQ.setBounds(6, 85, 97, 23);
    q.add(chckbxTargetJungleQ);
    
    lblSpeedQ = new JLabel("Speed: ");
    lblSpeedQ.setBounds(6, 149, 46, 14);
    q.add(lblSpeedQ);
    
    textSpeedQ = new JTextField();
    textSpeedQ.setText("0");
    textSpeedQ.setBounds(66, 146, 86, 20);
    q.add(textSpeedQ);
    textSpeedQ.setColumns(10);
    
    lblDelayQ = new JLabel("Delay:");
    lblDelayQ.setBounds(6, 174, 46, 14);
    q.add(lblDelayQ);
    
    textDelayQ = new JTextField();
    textDelayQ.setText("0.25");
    textDelayQ.setBounds(66, 171, 86, 20);
    q.add(textDelayQ);
    textDelayQ.setColumns(10);
    
    lblRangeQ = new JLabel("Range:");
    lblRangeQ.setBounds(6, 199, 46, 14);
    q.add(lblRangeQ);
    
    textRangeQ = new JTextField();
    textRangeQ.setText("0");
    textRangeQ.setBounds(66, 196, 86, 20);
    q.add(textRangeQ);
    textRangeQ.setColumns(10);
    
    lblWidthQ = new JLabel("Width:");
    lblWidthQ.setBounds(6, 224, 46, 14);
    q.add(lblWidthQ);
    
    textWidthQ = new JTextField();
    textWidthQ.setText("0");
    textWidthQ.setBounds(66, 221, 86, 20);
    q.add(textWidthQ);
    textWidthQ.setColumns(10);
    
    chckbxCollisionQ = new JCheckBox("Collision");
    chckbxCollisionQ.setBounds(66, 248, 97, 23);
    q.add(chckbxCollisionQ);
    
    chckbxAoeQ = new JCheckBox("AOE");
    chckbxAoeQ.setBounds(66, 271, 97, 23);
    q.add(chckbxAoeQ);
    
    comboBoxQ = new JComboBox();
    comboBoxQ.setModel(new DefaultComboBoxModel<>(new String[] { "linear", "circular", "cone", "nil" }));
    comboBoxQ.setSelectedIndex(3);
    comboBoxQ.setBounds(66, 301, 86, 23);
    q.add(comboBoxQ);
    
    lblTypeQ = new JLabel("Type:");
    lblTypeQ.setBounds(6, 305, 46, 14);
    q.add(lblTypeQ);
    
    chckbxUseInLaneclearQ = new JCheckBox("Use in Laneclear");
    chckbxUseInLaneclearQ.setBounds(281, 7, 121, 23);
    q.add(chckbxUseInLaneclearQ);
    
    chckbxUseInLasthitQ = new JCheckBox("Use in Lasthit");
    chckbxUseInLasthitQ.setBounds(281, 33, 121, 23);
    q.add(chckbxUseInLasthitQ);
    
    chckbxUseInHarrasQ = new JCheckBox("Use in Harras");
    chckbxUseInHarrasQ.setBounds(281, 59, 121, 23);
    q.add(chckbxUseInHarrasQ);
    
    chckbxUseInComboQ = new JCheckBox("Use in Combo");
    chckbxUseInComboQ.setBounds(281, 85, 121, 23);
    q.add(chckbxUseInComboQ);
    
    chckbxTargetMinionsQ = new JCheckBox("Target Minions");
    chckbxTargetMinionsQ.setBounds(105, 85, 97, 23);
    q.add(chckbxTargetMinionsQ);
    
    this.lblMinimumDistanceToQ = new JLabel("Minimum Distance to use:");
    this.lblMinimumDistanceToQ.setBounds(162, 149, 121, 14);
    q.add(this.lblMinimumDistanceToQ);
    
    textMinRangeQ = new JTextField();
    textMinRangeQ.setText("0");
    textMinRangeQ.setBounds(292, 146, 86, 20);
    q.add(textMinRangeQ);
    textMinRangeQ.setColumns(10);
    
    chckbxResetAaQ = new JCheckBox("Cast on AA");
    chckbxResetAaQ.setBounds(158, 170, 97, 23);
    q.add(chckbxResetAaQ);
    
    this.lblDamageFormularQ = new JLabel("Damage Formular:");
    this.lblDamageFormularQ.setBounds(162, 199, 111, 14);
    q.add(this.lblDamageFormularQ);
    
    textDmgFormQ = new JTextField();
    textDmgFormQ.setBounds(254, 196, 375, 20);
    q.add(textDmgFormQ);
    textDmgFormQ.setColumns(10);
    
    chckbxAutokillStealQ = new JCheckBox("Auto-Kill Steal (Requiers Damage Formular)");
    chckbxAutokillStealQ.setBounds(158, 220, 260, 23);
    q.add(chckbxAutokillStealQ);


    
    w = new JPanel();
    tabbedPane.addTab("W", null, w, null);
    w.setLayout(null);
    
    chckbxTargetEnemysW = new JCheckBox("Target Enemy's");
    chckbxTargetEnemysW.setBounds(6, 7, 121, 23);
    w.add(chckbxTargetEnemysW);
    
    chckbxTargetAllysW = new JCheckBox("Target Ally's");
    chckbxTargetAllysW.setBounds(6, 33, 121, 23);
    w.add(chckbxTargetAllysW);
    
    chckbxTargetSelfW = new JCheckBox("Target Self");
    chckbxTargetSelfW.setBounds(6, 59, 121, 23);
    w.add(chckbxTargetSelfW);
    
    chckbxIsSkillshotW = new JCheckBox("Is Skillshot");
    chckbxIsSkillshotW.setBounds(204, 7, 75, 23);
    w.add(chckbxIsSkillshotW);
    
    separatorW = new JSeparator();
    separatorW.setBounds(0, 115, 640, 2);
    w.add(separatorW);
    
    separator_1w = new JSeparator();
    separator_1w.setBounds(0, 120, 640, 2);
    w.add(separator_1w);
    
    chckbxTargetJungleW = new JCheckBox("Target Jungle");
    chckbxTargetJungleW.setBounds(6, 85, 97, 23);
    w.add(chckbxTargetJungleW);
    
    lblSpeedW = new JLabel("Speed: ");
    lblSpeedW.setBounds(6, 149, 46, 14);
    w.add(lblSpeedW);
    
    textSpeedW = new JTextField();
    textSpeedW.setText("0");
    textSpeedW.setBounds(66, 146, 86, 20);
    w.add(textSpeedW);
    textSpeedW.setColumns(10);
    
    lblDelayW = new JLabel("Delay:");
    lblDelayW.setBounds(6, 174, 46, 14);
    w.add(lblDelayW);
    
    textDelayW = new JTextField();
    textDelayW.setText("0.25");
    textDelayW.setBounds(66, 171, 86, 20);
    w.add(textDelayW);
    textDelayW.setColumns(10);
    
    lblRangeW = new JLabel("Range:");
    lblRangeW.setBounds(6, 199, 46, 14);
    w.add(lblRangeW);
    
    textRangeW = new JTextField();
    textRangeW.setText("0");
    textRangeW.setBounds(66, 196, 86, 20);
    w.add(textRangeW);
    textRangeW.setColumns(10);
    
    lblWidthW = new JLabel("Width:");
    lblWidthW.setBounds(6, 224, 46, 14);
    w.add(lblWidthW);
    
    textWidthW = new JTextField();
    textWidthW.setText("0");
    textWidthW.setBounds(66, 221, 86, 20);
    w.add(textWidthW);
    textWidthW.setColumns(10);
    
    chckbxCollisionW = new JCheckBox("Collision");
    chckbxCollisionW.setBounds(66, 248, 97, 23);
    w.add(chckbxCollisionW);
    
    chckbxAoeW = new JCheckBox("AOE");
    chckbxAoeW.setBounds(66, 271, 97, 23);
    w.add(chckbxAoeW);
    
    comboBoxW = new JComboBox();
    comboBoxW.setModel(new DefaultComboBoxModel<>(new String[] { "linear", "circular", "cone", "nil" }));
    comboBoxW.setSelectedIndex(3);
    comboBoxW.setBounds(66, 301, 86, 23);
    w.add(comboBoxW);
    
    lblTypeW = new JLabel("Type:");
    lblTypeW.setBounds(6, 305, 46, 14);
    w.add(lblTypeW);
    
    chckbxUseInLaneclearW = new JCheckBox("Use in Laneclear");
    chckbxUseInLaneclearW.setBounds(281, 7, 121, 23);
    w.add(chckbxUseInLaneclearW);
    
    chckbxUseInLasthitW = new JCheckBox("Use in Lasthit");
    chckbxUseInLasthitW.setBounds(281, 33, 121, 23);
    w.add(chckbxUseInLasthitW);
    
    chckbxUseInHarrasW = new JCheckBox("Use in Harras");
    chckbxUseInHarrasW.setBounds(281, 59, 121, 23);
    w.add(chckbxUseInHarrasW);
    
    chckbxUseInComboW = new JCheckBox("Use in Combo");
    chckbxUseInComboW.setBounds(281, 85, 121, 23);
    w.add(chckbxUseInComboW);
    
    chckbxTargetMinionsW = new JCheckBox("Target Minions");
    chckbxTargetMinionsW.setBounds(105, 85, 97, 23);
    w.add(chckbxTargetMinionsW);
    
    this.lblMinimumDistanceToW = new JLabel("Minimum Distance to use:");
    this.lblMinimumDistanceToW.setBounds(162, 149, 121, 14);
    w.add(this.lblMinimumDistanceToW);
    
    textMinRangeW = new JTextField();
    textMinRangeW.setText("0");
    textMinRangeW.setBounds(292, 146, 86, 20);
    w.add(textMinRangeW);
    textMinRangeW.setColumns(10);
    
    chckbxResetAaW = new JCheckBox("Cast on AA");
    chckbxResetAaW.setBounds(158, 170, 97, 23);
    w.add(chckbxResetAaW);
    
    this.lblDamageFormularW = new JLabel("Damage Formular:");
    this.lblDamageFormularW.setBounds(162, 199, 111, 14);
    w.add(this.lblDamageFormularW);
    
    textDmgFormW = new JTextField();
    textDmgFormW.setBounds(254, 196, 375, 20);
    w.add(textDmgFormW);
    textDmgFormW.setColumns(10);
    
    chckbxAutokillStealW = new JCheckBox("Auto-Kill Steal (Requiers Damage Formular)");
    chckbxAutokillStealW.setBounds(158, 220, 260, 23);
    w.add(chckbxAutokillStealW);

    
    Main.e = new JPanel();
    tabbedPane.addTab("E", null, Main.e, null);
    Main.e.setLayout(null);
    
    chckbxTargetEnemysE = new JCheckBox("Target Enemy's");
    chckbxTargetEnemysE.setBounds(6, 7, 121, 23);
    Main.e.add(chckbxTargetEnemysE);
    
    chckbxTargetAllysE = new JCheckBox("Target Ally's");
    chckbxTargetAllysE.setBounds(6, 33, 121, 23);
    Main.e.add(chckbxTargetAllysE);
    
    chckbxTargetSelfE = new JCheckBox("Target Self");
    chckbxTargetSelfE.setBounds(6, 59, 121, 23);
    Main.e.add(chckbxTargetSelfE);
    
    chckbxIsSkillshotE = new JCheckBox("Is Skillshot");
    chckbxIsSkillshotE.setBounds(204, 7, 75, 23);
    Main.e.add(chckbxIsSkillshotE);
    
    separatorE = new JSeparator();
    separatorE.setBounds(0, 115, 640, 2);
    Main.e.add(separatorE);
    
    separator_1e = new JSeparator();
    separator_1e.setBounds(0, 120, 640, 2);
    Main.e.add(separator_1e);
    
    chckbxTargetJungleE = new JCheckBox("Target Jungle");
    chckbxTargetJungleE.setBounds(6, 85, 97, 23);
    Main.e.add(chckbxTargetJungleE);
    
    lblSpeedE = new JLabel("Speed: ");
    lblSpeedE.setBounds(6, 149, 46, 14);
    Main.e.add(lblSpeedE);
    
    textSpeedE = new JTextField();
    textSpeedE.setText("0");
    textSpeedE.setBounds(66, 146, 86, 20);
    Main.e.add(textSpeedE);
    textSpeedE.setColumns(10);
    
    lblDelayE = new JLabel("Delay:");
    lblDelayE.setBounds(6, 174, 46, 14);
    Main.e.add(lblDelayE);
    
    textDelayE = new JTextField();
    textDelayE.setText("0.25");
    textDelayE.setBounds(66, 171, 86, 20);
    Main.e.add(textDelayE);
    textDelayE.setColumns(10);
    
    lblRangeE = new JLabel("Range:");
    lblRangeE.setBounds(6, 199, 46, 14);
    Main.e.add(lblRangeE);
    
    textRangeE = new JTextField();
    textRangeE.setText("0");
    textRangeE.setBounds(66, 196, 86, 20);
    Main.e.add(textRangeE);
    textRangeE.setColumns(10);
    
    lblWidthE = new JLabel("Width:");
    lblWidthE.setBounds(6, 224, 46, 14);
    Main.e.add(lblWidthE);
    
    textWidthE = new JTextField();
    textWidthE.setText("0");
    textWidthE.setBounds(66, 221, 86, 20);
    Main.e.add(textWidthE);
    textWidthE.setColumns(10);
    
    chckbxCollisionE = new JCheckBox("Collision");
    chckbxCollisionE.setBounds(66, 248, 97, 23);
    Main.e.add(chckbxCollisionE);
    
    chckbxAoeE = new JCheckBox("AOE");
    chckbxAoeE.setBounds(66, 271, 97, 23);
    Main.e.add(chckbxAoeE);
    
    comboBoxE = new JComboBox();
    comboBoxE.setModel(new DefaultComboBoxModel<>(new String[] { "linear", "circular", "cone", "nil" }));
    comboBoxE.setSelectedIndex(3);
    comboBoxE.setBounds(66, 301, 86, 23);
    Main.e.add(comboBoxE);
    
    lblTypeE = new JLabel("Type:");
    lblTypeE.setBounds(6, 305, 46, 14);
    Main.e.add(lblTypeE);
    
    chckbxUseInLaneclearE = new JCheckBox("Use in Laneclear");
    chckbxUseInLaneclearE.setBounds(281, 7, 121, 23);
    Main.e.add(chckbxUseInLaneclearE);
    
    chckbxUseInLasthitE = new JCheckBox("Use in Lasthit");
    chckbxUseInLasthitE.setBounds(281, 33, 121, 23);
    Main.e.add(chckbxUseInLasthitE);
    
    chckbxUseInHarrasE = new JCheckBox("Use in Harras");
    chckbxUseInHarrasE.setBounds(281, 59, 121, 23);
    Main.e.add(chckbxUseInHarrasE);
    
    chckbxUseInComboE = new JCheckBox("Use in Combo");
    chckbxUseInComboE.setBounds(281, 85, 121, 23);
    Main.e.add(chckbxUseInComboE);
    
    chckbxTargetMinionsE = new JCheckBox("Target Minions");
    chckbxTargetMinionsE.setBounds(105, 85, 97, 23);
    Main.e.add(chckbxTargetMinionsE);
    
    this.lblMinimumDistanceToE = new JLabel("Minimum Distance to use:");
    this.lblMinimumDistanceToE.setBounds(162, 149, 121, 14);
    Main.e.add(this.lblMinimumDistanceToE);
    
    textMinRangeE = new JTextField();
    textMinRangeE.setText("0");
    textMinRangeE.setBounds(292, 146, 86, 20);
    Main.e.add(textMinRangeE);
    textMinRangeE.setColumns(10);
    
    chckbxResetAaE = new JCheckBox("Cast on AA");
    chckbxResetAaE.setBounds(158, 170, 97, 23);
    Main.e.add(chckbxResetAaE);
    
    this.lblDamageFormularE = new JLabel("Damage Formular:");
    this.lblDamageFormularE.setBounds(162, 199, 111, 14);
    Main.e.add(this.lblDamageFormularE);
    
    textDmgFormE = new JTextField();
    textDmgFormE.setBounds(254, 196, 375, 20);
    Main.e.add(textDmgFormE);
    textDmgFormE.setColumns(10);
    
    chckbxAutokillStealE = new JCheckBox("Auto-Kill Steal (Requiers Damage Formular)");
    chckbxAutokillStealE.setBounds(158, 220, 260, 23);
    Main.e.add(chckbxAutokillStealE);

    
    r = new JPanel();
    tabbedPane.addTab("R", null, r, null);
    r.setLayout(null);
    
    chckbxTargetEnemysR = new JCheckBox("Target Enemy's");
    chckbxTargetEnemysR.setBounds(6, 7, 121, 23);
    r.add(chckbxTargetEnemysR);
    
    chckbxTargetAllysR = new JCheckBox("Target Ally's");
    chckbxTargetAllysR.setBounds(6, 33, 121, 23);
    r.add(chckbxTargetAllysR);
    
    chckbxTargetSelfR = new JCheckBox("Target Self");
    chckbxTargetSelfR.setBounds(6, 59, 121, 23);
    r.add(chckbxTargetSelfR);
    
    chckbxIsSkillshotR = new JCheckBox("Is Skillshot");
    chckbxIsSkillshotR.setBounds(204, 7, 75, 23);
    r.add(chckbxIsSkillshotR);
    
    separatorR = new JSeparator();
    separatorR.setBounds(0, 115, 640, 2);
    r.add(separatorR);
    
    separator_1r = new JSeparator();
    separator_1r.setBounds(0, 120, 640, 2);
    r.add(separator_1r);
    
    chckbxTargetJungleR = new JCheckBox("Target Jungle");
    chckbxTargetJungleR.setBounds(6, 85, 97, 23);
    r.add(chckbxTargetJungleR);
    
    lblSpeedR = new JLabel("Speed: ");
    lblSpeedR.setBounds(6, 149, 46, 14);
    r.add(lblSpeedR);
    
    textSpeedR = new JTextField();
    textSpeedR.setText("0");
    textSpeedR.setBounds(66, 146, 86, 20);
    r.add(textSpeedR);
    textSpeedR.setColumns(10);
    
    lblDelayR = new JLabel("Delay:");
    lblDelayR.setBounds(6, 174, 46, 14);
    r.add(lblDelayR);
    
    textDelayR = new JTextField();
    textDelayR.setText("0.25");
    textDelayR.setBounds(66, 171, 86, 20);
    r.add(textDelayR);
    textDelayR.setColumns(10);
    
    lblRangeR = new JLabel("Range:");
    lblRangeR.setBounds(6, 199, 46, 14);
    r.add(lblRangeR);
    
    textRangeR = new JTextField();
    textRangeR.setText("0");
    textRangeR.setBounds(66, 196, 86, 20);
    r.add(textRangeR);
    textRangeR.setColumns(10);
    
    lblWidthR = new JLabel("Width:");
    lblWidthR.setBounds(6, 224, 46, 14);
    r.add(lblWidthR);
    
    textWidthR = new JTextField();
    textWidthR.setText("0");
    textWidthR.setBounds(66, 221, 86, 20);
    r.add(textWidthR);
    textWidthR.setColumns(10);
    
    chckbxCollisionR = new JCheckBox("Collision");
    chckbxCollisionR.setBounds(66, 248, 97, 23);
    r.add(chckbxCollisionR);
    
    chckbxAoeR = new JCheckBox("AOE");
    chckbxAoeR.setBounds(66, 271, 97, 23);
    r.add(chckbxAoeR);
    
    comboBoxR = new JComboBox();
    comboBoxR.setModel(new DefaultComboBoxModel<>(new String[] { "linear", "circular", "cone", "nil" }));
    comboBoxR.setSelectedIndex(3);
    comboBoxR.setBounds(66, 301, 86, 23);
    r.add(comboBoxR);
    
    lblTypeR = new JLabel("Type:");
    lblTypeR.setBounds(6, 305, 46, 14);
    r.add(lblTypeR);
    
    chckbxUseInLaneclearR = new JCheckBox("Use in Laneclear");
    chckbxUseInLaneclearR.setBounds(281, 7, 121, 23);
    r.add(chckbxUseInLaneclearR);
    
    chckbxUseInLasthitR = new JCheckBox("Use in Lasthit");
    chckbxUseInLasthitR.setBounds(281, 33, 121, 23);
    r.add(chckbxUseInLasthitR);
    
    chckbxUseInHarrasR = new JCheckBox("Use in Harras");
    chckbxUseInHarrasR.setBounds(281, 59, 121, 23);
    r.add(chckbxUseInHarrasR);
    
    chckbxUseInComboR = new JCheckBox("Use in Combo");
    chckbxUseInComboR.setBounds(281, 85, 121, 23);
    r.add(chckbxUseInComboR);
    
    chckbxTargetMinionsR = new JCheckBox("Target Minions");
    chckbxTargetMinionsR.setBounds(105, 85, 97, 23);
    r.add(chckbxTargetMinionsR);
    
    this.lblMinimumDistanceToR = new JLabel("Minimum Distance to use:");
    this.lblMinimumDistanceToR.setBounds(162, 149, 121, 14);
    r.add(this.lblMinimumDistanceToR);
    
    textMinRangeR = new JTextField();
    textMinRangeR.setText("0");
    textMinRangeR.setBounds(292, 146, 86, 20);
    r.add(textMinRangeR);
    textMinRangeR.setColumns(10);
    
    chckbxResetAaR = new JCheckBox("Cast on AA");
    chckbxResetAaR.setBounds(158, 170, 97, 23);
    r.add(chckbxResetAaR);
    
    this.lblDamageFormularR = new JLabel("Damage Formular:");
    this.lblDamageFormularR.setBounds(162, 199, 111, 14);
    r.add(this.lblDamageFormularR);
    
    textDmgFormR = new JTextField();
    textDmgFormR.setBounds(254, 196, 375, 20);
    r.add(textDmgFormR);
    textDmgFormR.setColumns(10);
    
    chckbxAutokillStealR = new JCheckBox("Auto-Kill Steal (Requiers Damage Formular)");
    chckbxAutokillStealR.setBounds(158, 220, 260, 23);
    r.add(chckbxAutokillStealR);

    
    btnGenerateScript.addActionListener(new ActionListener()
        {
          public void actionPerformed(ActionEvent arg0) {
            btnGenerateScript.setEnabled(false);
            progressBar.setValue(5);
            if (textChampName.getText().length() <= 1) {
              btnGenerateScript.setEnabled(true);
              progressBar.setValue(0);
              String[] error = new String[4];
              error[0] = "Error";
              error[1] = "Champion Name Required";
              error[2] = String.valueOf(btnGenerateScript.getX());
              error[3] = String.valueOf(btnGenerateScript.getY());
              PopUp.main(error);
              return;
            } 
            if (textCreator.getText().length() <= 1) {
              btnGenerateScript.setEnabled(true);
              progressBar.setValue(0);
              String[] error = new String[4];
              error[0] = "Error";
              error[1] = "Creator Name Required";
              error[2] = String.valueOf(btnGenerateScript.getX());
              error[3] = String.valueOf(btnGenerateScript.getY());
              PopUp.main(error);

              
              return;
            } 
            
            progressBar.setValue(0);

















































            
            Main.GenHeader();





            
            progressBar.setValue(17);




            
            Main.GenOnLoad();




















































            
            progressBar.setValue(34);



















































            
            Main.GenOnTick();


            
            progressBar.setValue(51);


            
            Main.GenCaster();








            
            progressBar.setValue(68);








            
            Main.GenOnAA();




















            
            progressBar.setValue(85);




















            
            Main.GenCredits(); progressBar.setValue(100); btnGenerateScript.setEnabled(true); if (Main.this.chckbxOpenScriptAfter.isSelected()) { File f = new File("QWER-" + textChampName.getText() + ".lua"); try { Desktop.getDesktop().open(f); } catch (IOException e) { String[] error = new String[4]; error[0] = "Exception 4"; error[1] = "IOException"; error[2] = String.valueOf(btnGenerateScript.getX()); error[3] = String.valueOf(btnGenerateScript.getY()); PopUp.main(error); e.printStackTrace(); }  }
             } }); } private static void GenCredits() { BWriter("\n\n");
    BWriter("--[[\n   ______          ________ _____         _____                           _               _              _____ __                 _      \n  / __ \\ \\        / /  ____|  __ \\       / ____|                         | |             | |            / ____/_ |               | |     \n | |  | \\ \\  /\\  / /| |__  | |__) |_____| |  __  ___ _ __   ___ _ __ __ _| |_ ___  _ __  | |__  _   _  | (___  | |_ __ ___  _ __ | | ___ \n | |  | |\\ \\/  \\/ / |  __| |  _  /______| | |_ |/ _ \\ '_ \\ / _ \\ '__/ _` | __/ _ \\| '__| | '_ \\| | | |  \\___ \\ | | '_ ` _ \\| '_ \\| |/ _ \\\n | |__| | \\  /\\  /  | |____| | \\ \\      | |__| |  __/ | | |  __/ | | (_| | || (_) | |    | |_) | |_| |  ____) || | | | | | | |_) | |  __/\n  \\___\\_\\  \\/  \\/   |______|_|  \\_\\      \\_____|\\___|_| |_|\\___|_|  \\__,_|\\__\\___/|_|    |_.__/ \\__, | |_____/ |_|_| |_| |_| .__/|_|\\___|\n                                                                                                 __/ |                     | |           \n                                                                                                |___/                      |_|           \n]]--"); }

  
  private static void BWriter(String input) {
    try {
      PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter("QWER-" + textChampName.getText() + ".lua", true)));
      pw.println(input);
      pw.close();
    } catch (IOException e) {
      String[] error = new String[4];
      error[0] = "Exception 5";
      error[1] = "IOException";
      error[2] = String.valueOf(btnGenerateScript.getX());
      error[3] = String.valueOf(btnGenerateScript.getY());
      PopUp.main(error);
      e.printStackTrace();
    } 
  }
  
  private static void GenHeader() {
    File f = new File("QWER-" + textChampName.getText() + ".lua");
    if (f.exists())
      f.delete(); 
    BWriter("--QWER - " + textChampName.getText() + " by " + textCreator.getText());
    BWriter("if myHero.charName ~= \"" + textChampName.getText() + "\" then return end\n");
    BWriter("\n-- Downloads Nebelwoli's L33T UPL Prediction Manager--");
    BWriter("if not _G.UPLloaded then \n  if FileExist(LIB_PATH .. \"/UPL.lua\") then \n    require(\"UPL\") \n    _G.UPL = UPL() \n  else  \n    print(\"Downloading UPL, please don't press F9\") \n    DelayAction(function() DownloadFile(\"https://raw.github.com/nebelwolfi/BoL/master/Common/UPL.lua\"..\"?rand=\"..math.random(1,10000), LIB_PATH..\"UPL.lua\", function () print(\"Successfully downloaded UPL. Press F9 twice.\") end) end, 3)  \n    return \n  end \nend\n");
  }
  
  private static void GenOnLoad() {
    BWriter("function OnLoad() \n\tIniMenu() \n\tIniSpells() \nend \n \nfunction IniMenu() \n\tMenu = scriptConfig(\"QWER - " + textChampName.getText() + "\", \"qwer - " + textChampName.getText() + "\") ");
    if (chckbxUseInLaneclearQ.isSelected() || chckbxUseInLasthitQ.isSelected() || chckbxUseInHarrasQ.isSelected() || chckbxUseInComboQ.isSelected()) {
      BWriter("\tMenu:addSubMenu(\"Q - Settings\", \"q\")");
      if (chckbxUseInLaneclearQ.isSelected())
        BWriter("\tMenu.q:addSubMenu(\"Laneclear\", \"lc\")\n\t\tMenu.q.lc:addParam(\"use\",\"Use in Laneclear\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInLasthitQ.isSelected())
        BWriter("\tMenu.q:addSubMenu(\"Lasthit\", \"lh\")\n\t\tMenu.q.lh:addParam(\"use\",\"Use in Lasthit\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInHarrasQ.isSelected())
        BWriter("\tMenu.q:addSubMenu(\"Harras\", \"h\")\n\t\tMenu.q.h:addParam(\"use\",\"Use in Harras\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInComboQ.isSelected())
        BWriter("\tMenu.q:addSubMenu(\"Combo\", \"c\")\n\t\tMenu.q.c:addParam(\"use\",\"Use in Combo\", SCRIPT_PARAM_ONOFF, true)"); 
      BWriter("\n");
    } 
    if (chckbxUseInLaneclearW.isSelected() || chckbxUseInLasthitW.isSelected() || chckbxUseInHarrasW.isSelected() || chckbxUseInComboW.isSelected()) {
      BWriter("\tMenu:addSubMenu(\"W - Settings\", \"w\")");
      if (chckbxUseInLaneclearW.isSelected())
        BWriter("\tMenu.w:addSubMenu(\"Laneclear\", \"lc\")\n\t\tMenu.w.lc:addParam(\"use\",\"Use in Laneclear\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInLasthitW.isSelected())
        BWriter("\tMenu.w:addSubMenu(\"Lasthit\", \"lh\")\n\t\tMenu.w.lh:addParam(\"use\",\"Use in Lasthit\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInHarrasW.isSelected())
        BWriter("\tMenu.w:addSubMenu(\"Harras\", \"h\")\n\t\tMenu.w.h:addParam(\"use\",\"Use in Harras\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInComboW.isSelected())
        BWriter("\tMenu.w:addSubMenu(\"Combo\", \"c\")\n\t\tMenu.w.c:addParam(\"use\",\"Use in Combo\", SCRIPT_PARAM_ONOFF, true)"); 
      BWriter("\n");
    } 
    if (chckbxUseInLaneclearE.isSelected() || chckbxUseInLasthitE.isSelected() || chckbxUseInHarrasE.isSelected() || chckbxUseInComboE.isSelected()) {
      BWriter("\tMenu:addSubMenu(\"E - Settings\", \"e\")");
      if (chckbxUseInLaneclearE.isSelected())
        BWriter("\tMenu.e:addSubMenu(\"Laneclear\", \"lc\")\n\t\tMenu.e.lc:addParam(\"use\",\"Use in Laneclear\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInLasthitE.isSelected())
        BWriter("\tMenu.e:addSubMenu(\"Lasthit\", \"lh\")\n\t\tMenu.e.lh:addParam(\"use\",\"Use in Lasthit\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInHarrasE.isSelected())
        BWriter("\tMenu.e:addSubMenu(\"Harras\", \"h\")\n\t\tMenu.e.h:addParam(\"use\",\"Use in Harras\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInComboE.isSelected())
        BWriter("\tMenu.e:addSubMenu(\"Combo\", \"c\")\n\t\tMenu.e.c:addParam(\"use\",\"Use in Combo\", SCRIPT_PARAM_ONOFF, true)"); 
      BWriter("\n");
    } 
    if (chckbxUseInLaneclearR.isSelected() || chckbxUseInLasthitR.isSelected() || chckbxUseInHarrasR.isSelected() || chckbxUseInComboR.isSelected()) {
      BWriter("\tMenu:addSubMenu(\"R - Settings\", \"r\")");
      if (chckbxUseInLaneclearR.isSelected())
        BWriter("\tMenu.r:addSubMenu(\"Laneclear\", \"lc\")\n\t\tMenu.r.lc:addParam(\"use\",\"Use in Laneclear\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInLasthitR.isSelected())
        BWriter("\tMenu.r:addSubMenu(\"Lasthit\", \"lh\")\n\t\tMenu.r.lh:addParam(\"use\",\"Use in Lasthit\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInHarrasR.isSelected())
        BWriter("\tMenu.r:addSubMenu(\"Harras\", \"h\")\n\t\tMenu.r.h:addParam(\"use\",\"Use in Harras\", SCRIPT_PARAM_ONOFF, true)"); 
      if (chckbxUseInComboR.isSelected())
        BWriter("\tMenu.r:addSubMenu(\"Combo\", \"c\")\n\t\tMenu.r.c:addParam(\"use\",\"Use in Combo\", SCRIPT_PARAM_ONOFF, true)"); 
      BWriter("\n");
    } 
    BWriter("Menu:addSubMenu(\"Key Config\", \"keys\")\n\tMenu.keys:addParam(\"combo\", \"Combo Key\", SCRIPT_PARAM_ONKEYDOWN,false, string.byte(\" \"))\n\tMenu.keys:addParam(\"harras\", \"Harras Key\", SCRIPT_PARAM_ONKEYDOWN,false, string.byte(\"C\"))\n\tMenu.keys:addParam(\"laneclear\", \"Laneclear Key\", SCRIPT_PARAM_ONKEYDOWN,false, string.byte(\"V\"))\n\tMenu.keys:addParam(\"lasthit\", \"lasthit Key\", SCRIPT_PARAM_ONKEYDOWN,false, string.byte(\"X\"))");
    BWriter("end\n\n");
    BWriter("isSkillShotQ = " + String.valueOf(chckbxIsSkillshotQ.isSelected()));
    BWriter("isSkillShotW = " + String.valueOf(chckbxIsSkillshotW.isSelected()));
    BWriter("isSkillShotE = " + String.valueOf(chckbxIsSkillshotE.isSelected()));
    BWriter("isSkillShotR = " + String.valueOf(chckbxIsSkillshotR.isSelected()));
    BWriter("function IniSpells()");
    if (chckbxIsSkillshotQ.isSelected())
      BWriter("\tUPL:AddSpell(_Q, {speed = " + textSpeedQ.getText() + ", delay = " + textDelayQ.getText() + ", range = " + textRangeQ.getText() + ", width = " + textWidthQ.getText() + ", collision = " + chckbxCollisionQ.isSelected() + ", aoe = " + chckbxAoeQ.isSelected() + ", type = \"" + comboBoxQ.getItemAt(comboBoxQ.getSelectedIndex()) + "\"})"); 
    if (chckbxIsSkillshotW.isSelected())
      BWriter("\tUPL:AddSpell(_W, {speed = " + textSpeedW.getText() + ", delay = " + textDelayW.getText() + ", range = " + textRangeW.getText() + ", width = " + textWidthW.getText() + ", collision = " + chckbxCollisionW.isSelected() + ", aoe = " + chckbxAoeW.isSelected() + ", type = \"" + comboBoxW.getItemAt(comboBoxW.getSelectedIndex()) + "\"})"); 
    if (chckbxIsSkillshotE.isSelected())
      BWriter("\tUPL:AddSpell(_E, {speed = " + textSpeedE.getText() + ", delay = " + textDelayE.getText() + ", range = " + textRangeE.getText() + ", width = " + textWidthE.getText() + ", collision = " + chckbxCollisionE.isSelected() + ", aoe = " + chckbxAoeE.isSelected() + ", type = \"" + comboBoxE.getItemAt(comboBoxE.getSelectedIndex()) + "\"})"); 
    if (chckbxIsSkillshotR.isSelected())
      BWriter("\tUPL:AddSpell(_R, {speed = " + textSpeedR.getText() + ", delay = " + textDelayR.getText() + ", range = " + textRangeR.getText() + ", width = " + textWidthR.getText() + ", collision = " + chckbxCollisionR.isSelected() + ", aoe = " + chckbxAoeR.isSelected() + ", type = \"" + comboBoxR.getItemAt(comboBoxR.getSelectedIndex()) + "\"})"); 
    BWriter("\tUPL:AddToMenu2(Menu)");
    BWriter("end\n\n");
  }
  
  private static void GenOnTick() {
    BWriter("function OnTick()");
    BWriter("\tif not Menu then return end");
    BWriter("\tif Menu.keys.combo then\n\t\tif Menu.q and Menu.q.c then\n\t\t\tCastQ()\n\t\tend\n\t\tif Menu.w and Menu.w.c then\n\t\t\tCastW()\n\t\tend\n\t\tif Menu.e and Menu.e.c then\n\t\t\tCastE()\n\t\tend\n\t\tif Menu.r and Menu.r.c then\n\t\t\tCastR()\n\t\tend\n\tend\n\n\tif Menu.keys.harras then\n\t\tif Menu.q and Menu.q.h then\n\t\t\tCastQ()\n\t\tend\n\t\tif Menu.w and Menu.w.h then\n\t\t\tCastW()\n\t\tend\n\t\tif Menu.e and Menu.e.h then\n\t\t\tCastE()\n\t\tend\n\t\tif Menu.r and Menu.r.h then\n\t\t\tCastR()\n\t\tend\n\tend\n\n\tif Menu.keys.lasthit then\n\t\tif Menu.q and Menu.q.lh then\n\t\t\tCastQ()\n\t\tend\n\t\tif Menu.w and Menu.w.lh then\n\t\t\tCastW()\n\t\tend\n\t\tif Menu.e and Menu.e.lh then\n\t\t\tCastE()\n\t\tend\n\t\tif Menu.r and Menu.r.lh then\n\t\t\tCastR()\n\t\tend\n\tend\n\n\tif Menu.keys.laneclear then\n\t\tif Menu.q and Menu.q.lc then\n\t\t\tCastQ()\n\t\tend\n\t\tif Menu.w and Menu.w.lc then\n\t\t\tCastW()\n\t\tend\n\t\tif Menu.e and Menu.e.lc then\n\t\t\tCastE()\n\t\tend\n\t\tif Menu.e and Menu.r.lc then\n\t\t\tCastR()\n\t\tend\n\tend");
    GenKS();
    BWriter("end");
  }
  
  private static void GenCaster() {
    BWriter("function GetEnemyHeroTarget(range)\n\tlocal target = nil\n\tfor _, object in pairs(GetEnemyHeroes()) do\n\t\tif object and object.valid and not object.dead and myHero.type == object.type and ((myHero.team == 100 and object.team == 200) or (myHero.team == 200 and object.team == 100)) and GetDistance(object) < range then\n\t\t\tif not target then\n\t\t\t\ttarget = object\n\t\t\telseif target.health < object.health then\n\t\t\t\ttarget = object\n\t\t\tend\n\t\tend\n\tend\n\treturn target\nend\n\nenemyMinions = minionManager(MINION_ENEMY, 1500, player, MINION_SORT_HEALTH_ASC)\nJungleMinions = minionManager(MINION_JUNGLE, 1500, player, MINION_SORT_HEALTH_DES)\n\nfunction GetEnemyMinionTarget(range)\n\tenemyMinions.range = range\n\tenemyMinions:update()\n\treturn enemyMinions.objects[1]\nend\n\n\nfunction GetAllyHeroTarget(range)\n\tlocal target = nil\n\tfor _, object in pairs(GetAllyHeroes()) do\n\t\tif object and object.valid and not object.dead and object.team == myHero.team and not object.isMe and object.type == myHero.type and GetDistance(object) < range then\n\t\t\tif not target then\n\t\t\t\ttarget = object\n\t\t\telseif target.health < object.health then\n\t\t\t\ttarget = object\n\t\t\tend\n\t\tend\n\tend\n\treturn target\nend\n\n\nfunction GetJungleTarget(range)\n\tJungleMinions.range = range\n\tJungleMinions:update()\n\treturn JungleMinions.objects[1]\nend\n\nlocal targets = {}\nlastrequests = {0,0,0,0}\nfunction GetTarget(range,self,enemy,ally,jungle,minion)\n\n\tlocal target = nil\n\tif self then\n\t\tif ally then\n\t\t\tif lastrequests[2] > os.clock() and targets[2] and targets[2].valid and not targets[2].dead and GetDistance(targets[2]) < range then\n\t\t\t\ttarget = targets[2]\n\t\t\telse\n\t\t\t\ttarget = GetAllyHeroTarget()\n\t\t\t\ttargets[2] = target\n\t\t\t\tlastrequests[2] = os.clock()+0.1\n\t\t\tend\n\t\tend\n\t\treturn target or myHero\n\tend\n\t\n\tif ally then\n\t\tif lastrequests[2] > os.clock() and targets[2] and targets[2].valid and not targets[2].dead and GetDistance(targets[2]) < range then\n\t\t\ttarget = targets[2]\n\t\telse\n\t\t\ttargets[2] = target\n\t\t\t\n\t\t\tlastrequests[2] = os.clock()+0.1\n\t\t\ttarget = GetAllyHeroTarget(range)\n\t\tend\n\t\tif target then return target end\t\t\t\n\tend\n\t\n\tif enemy then\n\t\tif lastrequests[1] > os.clock() and targets[1] and targets[1].valid and not targets[1].dead and GetDistance(targets[1]) < range then\n\t\t\ttarget = targets[1]\n\t\telse\n\t\t\ttargets[1] = target\n\t\t\tlastrequests[1] = os.clock()+0.1\n\t\t\ttarget = GetEnemyHeroTarget(range)\n\t\tend\n\t\tif target then return target end\n\tend \n\t\n\tif jungle then\n\t\tif lastrequests[3] > os.clock() and targets[3] and targets[3].valid and not targets[3].dead and GetDistance(targets[3]) < range then\n\t\t\ttarget = targets[3]\n\t\telse\n\t\t\ttargets[3] = target\n\t\t\tlastrequests[3] = os.clock()+0.1\n\t\t\ttarget = GetJungleTarget(range)\n\t\tend\n\t\tif target then return target end\n\tend\n\t\n\tif minion then\n\t\tif lastrequests[4] > os.clock() and targets[4] and targets[4].valid and not targets[4].dead and GetDistance(targets[4]) < range then\n\t\t\ttarget = targets[4]\n\t\telse\n\t\t\ttargets[4] = target\n\t\t\tlastrequests[4] = os.clock()+0.1\n\t\t\ttarget = GetEnemyMinionTarget(range)\n\t\tend\n\t\tif target then return target end\n\tend\nend");
    BWriter("function CastQ(t)");
    BWriter("\tlocal target = t ~= nil and t or GetTarget(" + textRangeQ.getText() + "," + chckbxTargetSelfQ.isSelected() + "," + chckbxTargetEnemysQ.isSelected() + "," + chckbxTargetAllysQ.isSelected() + "," + chckbxTargetJungleQ.isSelected() + "," + chckbxTargetMinionsQ.isSelected() + ")\n\tif not target then return end\n\tif GetDistance(target) < " + textMinRangeQ.getText() + " then return end\n\tif myHero:CanUseSpell(_Q) ~= 0 then return end\n\tif isSkillShotQ then\n\t\tlocal pos, hs = UPL:Predict(_Q, myHero, target)\n\t\tif pos and hs and hs >= 2 then\n\t\t\tCastSpell(_Q, pos.x, pos.z)\n\t\tend\n\telse\n\t\tCastSpell(_Q, target)\n\tend");
    BWriter("end\n");
    BWriter("function CastW(t)");
    BWriter("\tlocal target = t ~= nil and t or GetTarget(" + textRangeW.getText() + "," + chckbxTargetSelfW.isSelected() + "," + chckbxTargetEnemysW.isSelected() + "," + chckbxTargetAllysW.isSelected() + "," + chckbxTargetJungleW.isSelected() + "," + chckbxTargetMinionsW.isSelected() + ")\n\tif not target then return end\n\tif GetDistance(target) < " + textMinRangeW.getText() + " then return end\n\tif myHero:CanUseSpell(_W) ~= 0 then return end\n\tif isSkillShotW then\n\t\tlocal pos, hs = UPL:Predict(_W, myHero, target)\n\t\tif pos and hs and hs >= 2 then\n\t\t\tCastSpell(_W, pos.x, pos.z)\n\t\tend\n\telse\n\t\tCastSpell(_W, target)\n\tend");
    BWriter("end\n");
    BWriter("function CastE(t)");
    BWriter("\tlocal target = t ~= nil and t or GetTarget(" + textRangeE.getText() + "," + chckbxTargetSelfE.isSelected() + "," + chckbxTargetEnemysE.isSelected() + "," + chckbxTargetAllysE.isSelected() + "," + chckbxTargetJungleE.isSelected() + "," + chckbxTargetMinionsE.isSelected() + ")\n\tif not target then return end\n\tif GetDistance(target) < " + textMinRangeE.getText() + " then return end\n\tif myHero:CanUseSpell(_E) ~= 0 then return end\n\tif isSkillShotE then\n\t\tlocal pos, hs = UPL:Predict(_E, myHero, target)\n\t\tif pos and hs and hs >= 2 then\n\t\t\tCastSpell(_E, pos.x, pos.z)\n\t\tend\n\telse\n\t\tCastSpell(_E, target)\n\tend");
    BWriter("end\n");
    BWriter("function CastR(t)");
    BWriter("\tlocal target = t ~= nil and t or GetTarget(" + textRangeR.getText() + "," + chckbxTargetSelfR.isSelected() + "," + chckbxTargetEnemysR.isSelected() + "," + chckbxTargetAllysR.isSelected() + "," + chckbxTargetJungleR.isSelected() + "," + chckbxTargetMinionsR.isSelected() + ")\n\tif not target then return end\n\tif GetDistance(target) < " + textMinRangeR.getText() + " then return end\n\tif myHero:CanUseSpell(_R) ~= 0 then return end\n\tif isSkillShotR then\n\t\tlocal pos, hs = UPL:Predict(_R, myHero, target)\n\t\tif pos and hs and hs >= 2 then\n\t\t\tCastSpell(_R, pos.x, pos.z)\n\t\tend\n\telse\n\t\tCastSpell(_R, target)\n\tend");
    BWriter("end\n");
  }
  
  private static void GenOnAA() {
    if (chckbxResetAaQ.isSelected() || chckbxResetAaW.isSelected() || chckbxResetAaE.isSelected() || chckbxResetAaR.isSelected()) {
      BWriter("function Set(list)\nlocal set = {}\nfor _, l in ipairs(list) do \n  set[l] = true \nend\nreturn set\nend\n\naltAttacks = Set { \"caitlynheadshotmissile\", \"frostarrow\", \"garenslash2\", \"kennenmegaproc\", \"lucianpassiveattack\", \"masteryidoublestrike\", \"quinnwenhanced\", \"renektonexecute\", \"renektonsuperexecute\", \"rengarnewpassivebuffdash\", \"trundleq\", \"xenzhaothrust\", \"xenzhaothrust2\", \"xenzhaothrust3\" }\n\nfunction OnProcessAttack(unit, attackProc)\n\tif unit and unit.valid and attackProc and attackProc.name and attackProc.target and (attackProc.name:lower():find(\"attack\") or altAttacks[spell.name:lower()]) then");
      if (chckbxResetAaQ.isSelected())
        BWriter("\t\tCastQ()"); 
      if (chckbxResetAaW.isSelected())
        BWriter("\t\tCastW()"); 
      if (chckbxResetAaE.isSelected())
        BWriter("\t\tCastE()"); 
      if (chckbxResetAaR.isSelected())
        BWriter("\t\tCastR()"); 
      BWriter("\tend\nend\n");
    } 
  }
  
  private static void GenKS() {
    if ((chckbxAutokillStealQ.isSelected() && textDmgFormQ.getText().length() > 1) || (chckbxAutokillStealW.isSelected() && textDmgFormW.getText().length() > 1) || (chckbxAutokillStealE.isSelected() && textDmgFormE.getText().length() > 1) || (chckbxAutokillStealR.isSelected() && textDmgFormR.getText().length() > 1)) {
      BWriter("\nlocal target = nil");
      if (chckbxAutokillStealQ.isSelected())
        BWriter("\ttarget = GetEnemyHeroTarget(" + textRangeQ.getText() + ")\n\tif target and target.health < " + textDmgFormQ.getText() + " then\n\t\tCastQ(target)\n\tend\n\ttarget = nil\n\t"); 
      if (chckbxAutokillStealW.isSelected())
        BWriter("\ttarget = GetEnemyHeroTarget(" + textRangeW.getText() + ")\n\tif target and target.health < " + textDmgFormW.getText() + " then\n\t\tCastQ(target)\n\tend\n\ttarget = nil\n\t"); 
      if (chckbxAutokillStealE.isSelected())
        BWriter("\ttarget = GetEnemyHeroTarget(" + textRangeE.getText() + ")\n\tif target and target.health < " + textDmgFormE.getText() + " then\n\t\tCastQ(target)\n\tend\n\ttarget = nil\n\t"); 
      if (chckbxAutokillStealR.isSelected())
        BWriter("\ttarget = GetEnemyHeroTarget(" + textRangeR.getText() + ")\n\tif target and target.health < " + textDmgFormR.getText() + " then\n\t\tCastQ(target)\n\tend\n\ttarget = nil\n\t"); 
    } 
  }
}
