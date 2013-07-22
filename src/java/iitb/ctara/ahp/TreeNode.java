/*
 * TreeNode.java
 *
 * Created on May 14, 2009, 12:01 PM
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
public class TreeNode implements Comparable, Serializable{
    
    String name;
    String signature; // good coding practice would have this as private
    int numChildren = 0;
    boolean isQualitative = false;
    
    TreeNode(){
        System.out.println("Default constructor");
    }
    
    public int compareTo(Object object){
        TreeNode treeNode = (TreeNode) object;
        return this.getSignature().compareTo(treeNode.getSignature());
    }
    
    /** Creates a new instance of TreeNode. To be used for creating an instance of the root node ONLY.*/
    public TreeNode(int i) {
        signature = "N_"+i;
    }
    
    /** Creates a new instance of TreeNode. To be used for creating an instance any non-root node.*/
    public TreeNode(TreeNode parent, int i){
        signature = parent.getSignature()+"_"+i;
    }
    
    public TreeNode(String signature) {
        this.signature = signature;
    }
    
    public String getSignature() { // Always a good idea for debuging
        return signature; 
    }
    
    public String toString() { // Always a good idea for debuging
        return getNodeName(); 
    }
    
    public void setNodeName(String name){
        this.name = name;
    }
    
    public String getNodeName(){
        return name;
    }
    
    public void setNumChildren(int numChildren){
        this.numChildren = numChildren;
    }
    
     public int getNumChildren(){
        return numChildren;
    }     
    
    public boolean isQualitative(){
        return isQualitative;
    }
    
    public boolean isQuantitative(){
        return !isQualitative();
    }
    
    public void setAttrType(String type){
        if(type.equals("qual")){
            isQualitative=true;
        }
        else{
            isQualitative=false;
        }
    }
}
