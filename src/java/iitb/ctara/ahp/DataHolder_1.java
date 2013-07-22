/*
 * DataHolder.java
 *
 * Created on May 13, 2009, 2:24 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */

package iitb.ctara.ahp;

import Jama.EigenvalueDecomposition;
import Jama.Matrix;
import edu.uci.ics.jung.graph.DirectedSparseGraph;
import edu.uci.ics.jung.graph.util.EdgeType;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.TreeMap;
import java.util.TreeSet;

/**
 *
 * @author admin
 */
public class DataHolder_1 implements Serializable{
    
    int num_techs = 1, num_persp = 1;
    DirectedSparseGraph directedSparseGraph;
    ArrayList<TreeNode> nodeList2Expand = new ArrayList<TreeNode>();
    ArrayList<TreeNode> unexpandedNodeList = new ArrayList<TreeNode>();
    float[][][][] qualAttribPerspEntry;
    TreeMap<String,Float> siblingPair2WeightMap = new TreeMap<String,Float>();
    TreeMap<String,Float> CIMap = new TreeMap<String,Float>();
    TreeMap<String,Float> lambdaMaxMap = new TreeMap<String,Float>();
    boolean visitedSiblingInfo = false;
    TreeMap<String,Float> node2EigenVecBasedWeightMap = new TreeMap<String,Float>();
    
    float[][] quantTechMatrix;
    boolean[][] quantPerspCostMatrix;
    String objectiveName = null;
    
    /** Creates a new instance of DataHolder */
    public DataHolder_1() {
        directedSparseGraph = new DirectedSparseGraph<TreeNode,TreeEdge>();
    }
    
    public void set_num_techs(int n){
        num_techs = n;
    }
    
    public void set_num_persp(int p){
        num_persp = p;
    }

    public int get_num_techs(){
        return num_techs;
    }
    
    public int getNumPersp(){
        return num_persp;
    }

    public void clearNodeList2Expand(){
        nodeList2Expand.clear();
    }
    
    public void addNode2Expand(TreeNode treeNode){
        nodeList2Expand.add(treeNode);
    }
    
    public int numNodes2Expand(){
        return nodeList2Expand.size();
    }
    
    public TreeNode getNode2Expand(int i){
        return nodeList2Expand.get(i);
    }
    
    public ArrayList<TreeNode> getNodeList2Expand(){
        return nodeList2Expand;
    }
    
    public void setNodeList2Expand(ArrayList<TreeNode> nodeList2Expand){
        if(this.nodeList2Expand.size()>0)   unexpandedNodeList = this.nodeList2Expand;
        this.nodeList2Expand = nodeList2Expand;
    }
    
    public void addEdge(TreeNode treeNode1, TreeNode treeNode2){
        directedSparseGraph.addEdge(new TreeEdge(treeNode1, treeNode2), treeNode1, treeNode2, EdgeType.DIRECTED);
    }
    
    public void setObjectiveName(String objectiveName){
        this.objectiveName = objectiveName;
    }
    
    public String getObjectiveName(){
        return objectiveName;
    }
    
    public void printGraph(){
        System.out.println("Directed Graph so far="+directedSparseGraph);
    }
    
    public int numAttributes(){
        return unexpandedNodeList.size();
    }
    
   public TreeNode getAttributeTreeNode(int i){
       return unexpandedNodeList.get(i);
   }
   
   public int getNumTechs(){
       return num_techs;
   }
   
   public void initializeQuantMatrix(){
       quantTechMatrix = new float[numAttributes()][getNumTechs()];
       quantPerspCostMatrix = new boolean[numAttributes()][getNumPersp()];
   }

   public void setQuantAttribForTech(int attrid, int techid, float value){
        quantTechMatrix[attrid][techid] = value;
   }
   
   public void setQuantAttribForPersp(int attrid, int techid, boolean isCost){
        quantPerspCostMatrix[attrid][techid] = isCost;
   }
   
   public void initializeQualMatrix(){
        qualAttribPerspEntry = new float[numAttributes()][getNumPersp()][getNumTechs()][getNumTechs()];
        for(int i=0;i<numAttributes();i++){
            for(int j=0; j<getNumPersp(); j++){
                for(int k=0; k<getNumTechs(); k++){
                    qualAttribPerspEntry[i][j][k][k] = 1;
                }
            }
        }
   }

   public void setQualAttribPerspEntry(int attrid, int perspid, int techid1, int techid2, float value){
        qualAttribPerspEntry[attrid][perspid][techid1][techid2] = value;
        qualAttribPerspEntry[attrid][perspid][techid2][techid1] = 1/value;
   }

   public TreeSet<TreeNode> getNeighbors(TreeNode treeNode){
       Collection<TreeNode> collection = (Collection<TreeNode>) directedSparseGraph.getSuccessors(treeNode);
       TreeSet<TreeNode> treeSet = new TreeSet<TreeNode>();
       Iterator<TreeNode> it = collection.iterator();
       while(it.hasNext()){
           treeSet.add(it.next());
       }
       return treeSet;
   }
   
   public TreeSet<TreeNode> getVertices(){
       Collection<TreeNode> collection = (Collection<TreeNode>) directedSparseGraph.getVertices();
       TreeSet<TreeNode> treeSet = new TreeSet<TreeNode>();
       Iterator<TreeNode> it = collection.iterator();
       while(it.hasNext()){
           treeSet.add(it.next());
       }
       return treeSet;
   }
   
   public void initializeSiblingPairWeights(){
       for(int perspId=0; perspId<getNumTechs(); perspId++){
            TreeSet vertexCollection = getVertices();
            Iterator it = vertexCollection.iterator();
            while(it.hasNext()){
                TreeNode treeNode = (TreeNode) it.next();
                TreeSet childrenCollection = getNeighbors(treeNode);
                if(childrenCollection.size()==0) continue;
                Iterator itChildren = childrenCollection.iterator();
                while(itChildren.hasNext()){
                    TreeNode childNode = (TreeNode) itChildren.next();
                    Iterator itChildren1 = childrenCollection.iterator();
                    while(itChildren1.hasNext()){
                        TreeNode childNode1 = (TreeNode) itChildren1.next();
                        int comparison = childNode.getSignature().compareTo(childNode1.getSignature());
                        if(comparison > 0){
                            setSiblingPairWeight(perspId, childNode.getSignature(), childNode1.getSignature(), 2f);
                        }
                        else if(comparison==0){
                            setSiblingPairWeight(perspId, childNode.getSignature(), childNode1.getSignature(), 1f);   
                        }
                    }
                }
            }
       }
   }
   
   public float getSiblingPairWeight(int perspId, String sibling1, String sibling2){
       String key1 = perspId+"#"+sibling1+"#"+sibling2;
       String key2 = perspId+"#"+sibling2+"#"+sibling1;
       
       if(siblingPair2WeightMap.containsKey(key1)){
            return siblingPair2WeightMap.get(key1); 
       }
       else{
           siblingPair2WeightMap.put(key1, 1f);
           siblingPair2WeightMap.put(key2, 1f);
           return 1f;
       }
   }
   
   public void setSiblingPairWeight(int perspId, String sibling1, String sibling2, float weight){
       String key1 = perspId+"#"+sibling1+"#"+sibling2;
       String key2 = perspId+"#"+sibling2+"#"+sibling1;
       
       siblingPair2WeightMap.put(key1, weight);
       if(weight>0)
           siblingPair2WeightMap.put(key2, 1f/weight);
       else
           siblingPair2WeightMap.put(key2, 0f);
   }
   
   String[] decomposeKey(String key){
       StringTokenizer st = new StringTokenizer(key,"#");
       String[] members = new String[3];
       members[0] = st.nextToken();
       members[1] = st.nextToken();
       members[2] = st.nextToken();
       return members;
   }
   
   public ArrayList getViolatorNodes(){
       ArrayList violatorNodes = new ArrayList();
       for(int perspId=0; perspId<getNumTechs(); perspId++){
            TreeSet vertexCollection = getVertices();
            Iterator it = vertexCollection.iterator();
            while(it.hasNext()){
                TreeNode treeNode = (TreeNode) it.next();
                TreeSet childrenCollection = getNeighbors(treeNode);
                if(childrenCollection.size()==0) continue;
                double[][] M = new double[childrenCollection.size()][childrenCollection.size()];
                int i=0;
                Iterator itChildren = childrenCollection.iterator();
                while(itChildren.hasNext()){
                    TreeNode childNode = (TreeNode) itChildren.next();
                    int j=0;
                    Iterator itChildren1 = childrenCollection.iterator();
                    while(itChildren1.hasNext()){
                        TreeNode childNode1 = (TreeNode) itChildren1.next();
                        M[i][j] = getSiblingPairWeight(perspId, childNode.getSignature(), childNode1.getSignature());
                        j++;
                    }
                    i++;
                }
                Matrix matrix = new Matrix(M);
                System.out.println("MATRIX="+matrix);
                EigenvalueDecomposition E = new EigenvalueDecomposition(matrix);
                double[] eigenvalues = E.getRealEigenvalues();
                System.out.println("eigenvalues[0]="+eigenvalues[0] +" eigenvalues[1]="+eigenvalues[1]+" eigenvalues[2]="+eigenvalues[2]);
                for(int j=0; j<M.length; j++){
                    for(int k=0; k<M[j].length; k++){
                        System.out.print("M["+j+"]["+k+"]="+M[j][k]+" \t");
                    }
                }
                System.out.println();
                double CI  = (eigenvalues[0] - M.length)/(M.length - 1);
                lambdaMaxMap.put(perspId+"#"+treeNode.getSignature(), (float) eigenvalues[0]);
                CIMap.put(perspId+"#"+treeNode.getSignature(), (float) CI);
                
                if(!visitedSiblingInfo){
                    violatorNodes.add(true);
                }
                else if(CI>0.1){
                    violatorNodes.add(true);
                }
                else{
                    violatorNodes.add(false);
                }
                violatorNodes.add(perspId);
                violatorNodes.add(treeNode);

                double[][] V = E.getV().getArray();
                double[] eigenVec = new double[V.length];//E.getV().getArray()[0];
                for(int p=0; p<V.length; p++){
                    eigenVec[p] = V[p][0];
                }
                printArray(eigenVec);
                double[] normEigenVec = normalize(eigenVec);
                printArray(normEigenVec);
                itChildren = childrenCollection.iterator();
                int k=0;
                while(itChildren.hasNext()){
                    TreeNode childNode = (TreeNode) itChildren.next();
                    node2EigenVecBasedWeightMap.put(perspId+"#"+childNode.getSignature(), (float) normEigenVec[k]);
                }
            }
       }
       return violatorNodes;
   }
   
   public float getCI(int perspId, String signature){
       return CIMap.get(perspId+"#"+signature);
   }
   
   public float getLambdaMax(int perspId, String signature){
       return lambdaMaxMap.get(perspId+"#"+signature);
   }
   
   public void set_visitedSiblingInfo(){
       visitedSiblingInfo = true;
   }
   
   public double[] normalize(double[] input){
       double[] output = new double[input.length];
       double norm = 0;
       for(int i=0; i<input.length; i++){
           norm+= input[i];
       }
       for(int i=0; i<input.length; i++){
           output[i] = input[i]/norm;
       }
       return output;
   }
   
   public void printArray(double[] input){
       System.out.print("Array is:\t");
       for(int i=0; i<input.length; i++){
           System.out.print(input[i]+"  ");
       }
       System.out.println();
   }
}