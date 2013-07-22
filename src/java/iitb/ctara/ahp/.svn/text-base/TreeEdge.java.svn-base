/*
 * TreeEdge.java
 *
 * Created on May 15, 2009, 10:36 AM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */

package iitb.ctara.ahp;

import java.io.Serializable;

/**
 *
 * @author admin
 */
public class TreeEdge implements Serializable {
    
    String signature;
    
    TreeEdge(){
        System.out.println("Default constructor");
    }
     
    /** Creates a new instance of TreeEdge */
    public TreeEdge(TreeNode treeNode1, TreeNode treeNode2) {
        signature = treeNode1.getSignature()+"-->"+treeNode2.getSignature();
    }
    
    public String toString(){
        return signature;
    }
    
    public String getSignature(){
        return signature;
    }
    
}
