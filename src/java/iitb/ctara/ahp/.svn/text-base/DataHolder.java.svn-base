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
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import edu.uci.ics.jung.algorithms.layout.FRLayout;
import edu.uci.ics.jung.algorithms.layout.ISOMLayout;
import edu.uci.ics.jung.algorithms.layout.RadialTreeLayout;
import edu.uci.ics.jung.algorithms.layout.StaticLayout;
import edu.uci.ics.jung.graph.DelegateForest;
import edu.uci.ics.jung.graph.DelegateTree;
import edu.uci.ics.jung.graph.DirectedSparseGraph;
import edu.uci.ics.jung.graph.util.EdgeType;
import edu.uci.ics.jung.visualization.VisualizationViewer;
import edu.uci.ics.jung.visualization.decorators.ToStringLabeller;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Paint;
import java.awt.Stroke;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.TreeMap;
import java.util.TreeSet;

import edu.uci.ics.jung.algorithms.layout.CircleLayout;
import edu.uci.ics.jung.algorithms.layout.Layout;
import edu.uci.ics.jung.graph.DirectedSparseGraph;
import edu.uci.ics.jung.graph.Graph;
import edu.uci.ics.jung.visualization.BasicVisualizationServer;
import java.awt.Dimension;
import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.text.Position;
import org.apache.commons.collections15.Transformer;

/**
 *
 * @author admin
 */
public class DataHolder implements Serializable{

    String objectiveName = "default";
    String workSpace = "";

    int depth=1;
    int num_techs = 1, num_persp = 1;
    DirectedSparseGraph directedSparseGraph;
    ArrayList<TreeNode> nodeList2Expand = new ArrayList<TreeNode>();
    ArrayList<TreeNode> unexpandedNodeList = new ArrayList<TreeNode>();
    ArrayList<String> technologyNames = new ArrayList<String>();
    ArrayList<String> perspNames = new ArrayList<String>();

    /*
    float[][][][] qualAttribPerspEntry;
    float[][] quantTechMatrix;
    boolean[][] quantPerspCostMatrix;
    */
    TreeMap<String,Float> siblingPair2WeightMap = new TreeMap<String,Float>();
    TreeMap<String,Float> CIMapForSiblingInfo = new TreeMap<String,Float>();
    TreeMap<String,Float> lambdaMaxMapForSiblingInfo = new TreeMap<String,Float>();
    TreeMap<String,Float> CIMapForQualMatrix = new TreeMap<String,Float>();
    TreeMap<String,Float> lambdaMaxMapForQualMatrix = new TreeMap<String,Float>();
    boolean visitedSiblingInfo = false, visitedQualMatrixInputInfo = false;
    TreeMap<String,Float> node2EigenVecBasedWeightMapForSiblingInfo = new TreeMap<String,Float>();
    TreeMap<String,Float> node2EigenVecBasedWeightMapForQualMatrix = new TreeMap<String,Float>();
    TreeMap<String,Float> node2WeightMap = new TreeMap<String,Float>();
    TreeMap<String,Float> quantAttribTechEntry = new TreeMap<String,Float>();
    TreeMap<String,Boolean> quantPerspAttribCostEntry = new TreeMap<String,Boolean>();
    TreeMap<String,Float> qualPerspAttribEntry = new TreeMap<String,Float>();
    TreeMap<TreeNode,TreeSet<TreeNode>> node2NeighbourMap = new TreeMap<TreeNode,TreeSet<TreeNode>>();
    boolean readFromDisk = false;

    TreeMap<String,Float> minQuantAttribAcrossTechs = new TreeMap<String,Float>();
    TreeMap<String,Float> maxQuantAttribAcrossTechs = new TreeMap<String,Float>();

    float CIThresholdForSiblingInfo = 0.1f;
    float CIThresholdForQualMatrix = 0.1f;
    float CILThresholdForQualMatrix = CIThresholdForQualMatrix;   // Newly declared variable for local threshold (for different matrices, used at qualMatrixInput.jsp)


    /** Creates a new instance of DataHolder */
    public DataHolder() {
        directedSparseGraph = new DirectedSparseGraph<TreeNode,TreeEdge>();
    }

    public int incrementDepth(){
        return depth++;
    }

    public int getDepth(){
        return depth;
    }

    public void set_num_techs(int n){
        num_techs = n;
        technologyNames = new ArrayList<String>(n);
    }

    public void set_num_persp(int p){
        num_persp = p;
        perspNames = new ArrayList<String>(p);
    }

    public int getNumPersp(){
        return num_persp;
    }

    public void setTechnologyName(int techId, String technologyName){
        technologyNames.add(techId, technologyName);
    }

    public void setPerspName(int perspId, String perspName){
        perspNames.add(perspId, perspName);
    }

    public String getTechnologyName(int techId){
        return technologyNames.get(techId);
    }

    public String getPerspName(int perspId){
        return perspNames.get(perspId);
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

    public void setWorkSpace(String workSpace){
        this.workSpace = workSpace;
    }

     public String getWorkSpace(){
        return workSpace;
    }

    public void printGraph(){
/*        int width = 900, height = 700;
        System.out.println("Directed Graph so far="+directedSparseGraph);
        Layout<TreeNode, TreeEdge> layout = new RadialTreeLayout(new DelegateForest(directedSparseGraph));
        layout.setSize(new Dimension(width,height)); // sets the initial size of the space
        width+=50; height+=50;
        // The BasicVisualizationServer<V,E> is parameterized by the edge types
        VisualizationViewer<TreeNode,TreeEdge> vv =
        new VisualizationViewer<TreeNode,TreeEdge>(layout);
        vv.setPreferredSize(new Dimension(width,height)); //Sets the viewing area size

        // Setup up a new vertex to paint transformer...
        Transformer<TreeNode,Paint> vertexPaint = new Transformer<TreeNode,Paint>() {
            public Paint transform(TreeNode treeNode) {
                return Color.GREEN;
            }
        };

        // Set up a new stroke Transformer for the edges
        float dash[] = {10.0f};
        final Stroke edgeStroke = new BasicStroke(1.0f, BasicStroke.CAP_BUTT, BasicStroke.JOIN_MITER, 10.0f, dash, 0.0f);
        Transformer<TreeEdge, Stroke> edgeStrokeTransformer = new Transformer<TreeEdge, Stroke>() {
            public Stroke transform(TreeEdge s) {
                return edgeStroke;
            }
        };

        vv.getRenderContext().setVertexFillPaintTransformer(vertexPaint);
        vv.getRenderContext().setEdgeStrokeTransformer(edgeStrokeTransformer);
        vv.getRenderContext().setVertexLabelTransformer(new ToStringLabeller());
        //vv.getRenderContext().setEdgeLabelTransformer(new ToStringLabeller());
        //vv.getRenderer().getVertexLabelRenderer().setPosition((new Position()));

        JFrame frame = new JFrame("AHP Graph");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().add(vv);
        frame.pack();
        frame.setVisible(true);


        writeJPEGImage(vv, getWorkSpace()+"/"+getObjectiveName()+"graph.jpg", width, height);
  */
    }

    /*
    public void saveGraphAsJPEG(Graph myGraph, String filename) {
      Dimension size = myGraph.getSize();
      BufferedImage myImage =
        new BufferedImage(size.width, size.height,
            BufferedImage.TYPE_INT_RGB);
      Graphics2D g2 = myImage.createGraphics();
      myGraph.paintComponent(g2);
      try {
        OutputStream out = new FileOutputStream(filename);
           JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
         encoder.encode(myImage);
         out.close();
       } catch (Exception e) {
         System.out.println(e);
      }
    }
    */


    /**
* Convert the viewed graph to a JPEG image written in the specified file name.
* The size of the image is the size of the layout. The background color is this one
* of the visualization viewer. The default representation of the image is 8-bit RGB
* color components, corresponding to a Windows- or Solaris- style BGR color model,
* with the colors Blue, Green, and Red packed into integer pixels.
*/

  public void writeJPEGImage(VisualizationViewer<TreeNode,TreeEdge> vv, String filename, int width, int height) {
    Color bg = vv.getBackground();
    BufferedImage bi = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
    Graphics2D graphics = bi.createGraphics();
    //graphics.setColor(bg);
    graphics.fillRect(0,0, width, height);
    vv.paintComponents(graphics);

    try{
       ImageIO.write(bi,"jpeg",new File(filename));
    }
    catch(Exception e){e.printStackTrace();}


  }

    public void commitTree(){
       Collection<TreeNode> collection = (Collection<TreeNode>) directedSparseGraph.getVertices();
       TreeSet<TreeNode> vertexSet = new TreeSet<TreeNode>();
       Iterator<TreeNode> it = collection.iterator();
       while(it.hasNext()){
           vertexSet.add(it.next());
       }

       it = vertexSet.iterator();
       while(it.hasNext()){
            TreeNode treeNode = it.next();
            Collection<TreeNode> succCollection = (Collection<TreeNode>) directedSparseGraph.getSuccessors(treeNode);
            TreeSet<TreeNode> succSet = new TreeSet<TreeNode>();
            Iterator<TreeNode> succIt = succCollection.iterator();
            while(succIt.hasNext()){
               succSet.add(succIt.next());
            }
            node2NeighbourMap.put(treeNode,succSet);
            if(succCollection.size()==0){
                unexpandedNodeList.add(treeNode);
            }
       }
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

   public void setToReadFromDisk(){
       readFromDisk = true;
   }

   public void unsetToReadFromDisk(){
       readFromDisk = false;
   }

    public boolean readFromDisk(){
       return readFromDisk;
   }

   public void setQuantAttribForTech(String signature, int techId, float value){
        //quantTechMatrix[attrid][techId] = value;
        quantAttribTechEntry.put(signature+"#"+techId, value);
   }

   public float getQuantAttribForTech(String signature, int techId){
       float value = 1;
       if(quantAttribTechEntry.containsKey(signature+"#"+techId)){
           return quantAttribTechEntry.get(signature+"#"+techId);
       }
       else{
           quantAttribTechEntry.put(signature+"#"+techId, value);
           return value;
       }
   }

   public float getMaxQuantAttribAcrossTechs(String signature){
       if(maxQuantAttribAcrossTechs.containsKey(signature)) return maxQuantAttribAcrossTechs.get(signature);

       Iterator<String> it = quantAttribTechEntry.keySet().iterator();
       float maxValue = Float.MIN_VALUE;
       while(it.hasNext()){
           String key = it.next();
           float value = 0;
           if(key.startsWith(signature+"#")){
               value = quantAttribTechEntry.get(key);
               if(value > maxValue){
                   maxValue = value;
               }
           }
       }
       maxQuantAttribAcrossTechs.put(signature, maxValue);
       return maxValue;
   }

    public float getMinQuantAttribAcrossTechs(String signature){
       if(minQuantAttribAcrossTechs.containsKey(signature)) return minQuantAttribAcrossTechs.get(signature);

       Iterator<String> it = quantAttribTechEntry.keySet().iterator();
       float minValue = Float.MAX_VALUE;
       while(it.hasNext()){
           String key = it.next();
           float value = 0;
           if(key.startsWith(signature+"#")){
               value = quantAttribTechEntry.get(key);
               if(value < minValue){
                   minValue = value;
               }
           }
       }
       minQuantAttribAcrossTechs.put(signature, minValue);
       return minValue;
   }

   public void setQuantAttribForPersp(int perspId, String signature, boolean isCost){
        //quantPerspCostMatrix[attrid][techId] = isCost;
       quantPerspAttribCostEntry.put(perspId+"#"+signature, isCost);
   }

   public boolean getQuantAttribForPersp(int perspId, String signature){
       if(quantPerspAttribCostEntry.containsKey(perspId+"#"+signature)){
           return quantPerspAttribCostEntry.get(perspId+"#"+signature);
       }
       else{
           boolean isCost = true;
           quantPerspAttribCostEntry.put(perspId+"#"+signature, isCost);
           return isCost;
       }
   }


   public void setQualAttribPerspEntry(int perspid, String signature, int techId1, int techId2, float value){
        qualPerspAttribEntry.put(perspid+"#"+signature+"#"+techId1+"#"+techId2, value);
        qualPerspAttribEntry.put(perspid+"#"+signature+"#"+techId2+"#"+techId1, 1/value);
   }

   public float getQualAttribPerspEntry(int perspid, String signature, int techId1, int techId2){
        if(qualPerspAttribEntry.containsKey(perspid+"#"+signature+"#"+techId1+"#"+techId2)){
            return qualPerspAttribEntry.get(perspid+"#"+signature+"#"+techId1+"#"+techId2);
        }
        else{
            float retValue = 1f;
            if(techId2 > techId1){
                retValue = 2f;
            }
            else if(techId2 < techId1){
                retValue = 0.5f;
            }
            qualPerspAttribEntry.put(perspid+"#"+signature+"#"+techId1+"#"+techId2,retValue);
            return retValue;
        }
   }


      public ArrayList getViolatorQualMatrixNodes(){
       ArrayList violatorNodes = new ArrayList();
       for(int perspId=0; perspId<getNumPersp(); perspId++){
            for(int attrId=0; attrId<numAttributes(); attrId++){
                TreeNode treeNode = getAttributeTreeNode(attrId);
                if(!treeNode.isQualitative()) continue;
                double[][] M = new double[getNumTechs()][getNumTechs()];
                for(int techId=0; techId<getNumTechs(); techId++){
                    for(int techId1=0; techId1<getNumTechs(); techId1++){
                            M[techId][techId1] = getQualAttribPerspEntry(perspId, treeNode.getSignature(), techId, techId1);
                    }
                }
                Matrix matrix = new Matrix(M);
                System.out.println("MATRIX="+matrix);
                EigenvalueDecomposition E = new EigenvalueDecomposition(matrix);
                double[] eigenvalues = E.getRealEigenvalues();
                System.out.println("eigenvalues=");
                printArray(eigenvalues);

                int maxEigenvalueIndx = -1;
                double maxEigenvalue = Double.NEGATIVE_INFINITY;
                for(int j=0;j<eigenvalues.length;j++){
                    if(maxEigenvalue < eigenvalues[j]){
                        maxEigenvalue = eigenvalues[j];
                        maxEigenvalueIndx = j;
                    }
                }
                for(int j=0; j<M.length; j++){
                    for(int k=0; k<M[j].length; k++){
                        System.out.print("M["+j+"]["+k+"]="+M[j][k]+" \t");
                    }
                }
                System.out.println();
                double CI  = (eigenvalues[maxEigenvalueIndx] - M.length)/(M.length - 1);
                lambdaMaxMapForQualMatrix.put(perspId+"#"+treeNode.getSignature(), (float) eigenvalues[maxEigenvalueIndx]);
                CIMapForQualMatrix.put(perspId+"#"+treeNode.getSignature(), (float) CI);

                if(!visitedQualMatrixInputInfo){
                    violatorNodes.add(true);
                }
                else if(CI>CILThresholdForQualMatrix){   //Earlier it was CI>CIThreshold.   But Now Preference is given to localthreshold.
                    violatorNodes.add(true);
                }
                else{
                    violatorNodes.add(false);
                }
                violatorNodes.add(perspId);
                violatorNodes.add(attrId);

                double[][] V = E.getV().getArray();
                double[] eigenVec = new double[V.length];//E.getV().getArray()[maxEigenvalueIndx];
                for(int p=0; p<V.length; p++){
                    eigenVec[p] = V[p][maxEigenvalueIndx];
                }
                System.out.println("eigenVec=");
                printArray(eigenVec);
                double[] normEigenVec = normalize(eigenVec);

                System.out.println("normEigenVec=");
                printArray(normEigenVec);
                for(int techId=0; techId<getNumTechs(); techId++){
                    node2EigenVecBasedWeightMapForQualMatrix.put(perspId+"#"+treeNode.getSignature()+"#"+techId, (float) normEigenVec[techId]);
                }
            }
       }
       return violatorNodes;
   }

   public float getQualAttrValue(int perspId, TreeNode treeNode, int techId){
       return node2EigenVecBasedWeightMapForQualMatrix.get(perspId+"#"+treeNode.getSignature()+"#"+techId);
   }

   public float getQuanAttrValue(int perspId, TreeNode treeNode, int techId){
       boolean isCost = getQuantAttribForPersp(perspId, treeNode.getSignature());
       float tempValue = getQuantAttribForTech(treeNode.getSignature(), techId);
       float value, maxValue = getMaxQuantAttribAcrossTechs(treeNode.getSignature()), minValue = getMinQuantAttribAcrossTechs(treeNode.getSignature());
       float den;
       if(maxValue == minValue){
           den = getNumTechs();
       }
       else{
           den = maxValue - minValue;
       }
       if(isCost){
           value = (maxValue - tempValue)/den;
       }
       else{
           value = (tempValue - minValue)/den;
       }
       return value;
   }

   public boolean get_visitedQualMatrixInputInfo(){
       return visitedQualMatrixInputInfo;
   }

   public void set_visitedQualMatrixInputInfo(){
       visitedQualMatrixInputInfo = true;
   }

   public void setCIThresholdForQualMatrix(float CIThresholdForQualMatrix){
       this.CIThresholdForQualMatrix = CIThresholdForQualMatrix;
   }

   public float getCIThresholdForQualMatrix(){
       return CIThresholdForQualMatrix;
   }



   public void setCILThresholdForQualMatrix(float CILThresholdForQualMatrix){
       this.CILThresholdForQualMatrix = CILThresholdForQualMatrix;
   }

   public float getCILThresholdForQualMatrix(){
       return CILThresholdForQualMatrix;
   }

   public TreeSet<TreeNode> getSuccessors(TreeNode treeNode){
       return node2NeighbourMap.get(treeNode);
   }

   public TreeSet<TreeNode> getVertices(){
       TreeSet<TreeNode> treeSet = new TreeSet<TreeNode>(node2NeighbourMap.keySet());
       return treeSet;
   }

   public TreeSet<TreeNode> getLevel1Vertices(){
       TreeNode rootNode = new TreeNode(0);
       rootNode.setNodeName(getObjectiveName());
       TreeSet<TreeNode> treeSet = node2NeighbourMap.get(rootNode);
       return treeSet;
   }

   /*
   public void initializeSiblingPairWeights(){
       for(int perspId=0; perspId<getNumPersp(); perspId++){
            TreeSet vertexCollection = getVertices();
            Iterator it = vertexCollection.iterator();
            while(it.hasNext()){
                TreeNode treeNode = (TreeNode) it.next();
                TreeSet childrenCollection = getSuccessors(treeNode);
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
   */

   public float getSiblingPairWeight(int perspId, String sibling1, String sibling2){
       String key1 = perspId+"#"+sibling1+"#"+sibling2;
       String key2 = perspId+"#"+sibling2+"#"+sibling1;

       if(siblingPair2WeightMap.containsKey(key1)){
            return siblingPair2WeightMap.get(key1);
       }
       else{
           if(key1.compareTo(key2)>0){
               siblingPair2WeightMap.put(key1, 2f);
               siblingPair2WeightMap.put(key2, 0.5f);
               return 2f;
           }
           else if(key1.compareTo(key2)<0){
               siblingPair2WeightMap.put(key1, 0.5f);
               siblingPair2WeightMap.put(key2, 2f);
               return 0.5f;
           }
           else{
               siblingPair2WeightMap.put(key1, 1f);
               siblingPair2WeightMap.put(key2, 1f);
               return 1f;
           }
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

   public ArrayList getViolatorSiblingNodes(){
       ArrayList violatorNodes = new ArrayList();
       for(int perspId=0; perspId<getNumPersp(); perspId++){
            TreeSet vertexCollection = getVertices();
            Iterator it = vertexCollection.iterator();
            while(it.hasNext()){
                TreeNode treeNode = (TreeNode) it.next();
                TreeSet childrenCollection = getSuccessors(treeNode);
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
                System.out.println("eigenvalues=");
                printArray(eigenvalues);

                int maxEigenvalueIndx = -1;
                double maxEigenvalue = Double.NEGATIVE_INFINITY;
                for(int j=0;j<eigenvalues.length;j++){
                    if(maxEigenvalue < eigenvalues[j]){
                        maxEigenvalue = eigenvalues[j];
                        maxEigenvalueIndx = j;
                    }
                }

                for(int j=0; j<M.length; j++){
                    for(int k=0; k<M[j].length; k++){
                        System.out.print("M["+j+"]["+k+"]="+M[j][k]+" \t");
                    }
                }
                System.out.println();
                double CI  = (eigenvalues[maxEigenvalueIndx] - M.length)/(M.length - 1);
                lambdaMaxMapForSiblingInfo.put(perspId+"#"+treeNode.getSignature(), (float) eigenvalues[maxEigenvalueIndx]);
                CIMapForSiblingInfo.put(perspId+"#"+treeNode.getSignature(), (float) CI);

                if(!visitedSiblingInfo){
                    violatorNodes.add(true);
                }
                else if(CI>CIThresholdForSiblingInfo){
                    violatorNodes.add(true);
                }
                else{
                    violatorNodes.add(false);
                }
                violatorNodes.add(perspId);
                violatorNodes.add(treeNode);

                double[][] V = E.getV().getArray();
                double[] eigenVec = new double[V.length];//E.getV().getArray()[maxEigenvalueIndx];
                for(int p=0; p<V.length; p++){
                    eigenVec[p] = V[p][maxEigenvalueIndx];
                }
                System.out.println("eigenVec=");
                printArray(eigenVec);
                double[] normEigenVec = normalize(eigenVec);

                System.out.println("normEigenVec=");
                printArray(normEigenVec);
                itChildren = childrenCollection.iterator();
                int k=0;
                while(itChildren.hasNext()){
                    TreeNode childNode = (TreeNode) itChildren.next();
                    node2EigenVecBasedWeightMapForSiblingInfo.put(perspId+"#"+childNode.getSignature(), (float) normEigenVec[k]);
                    k++;
                }
            }
       }
       return violatorNodes;
   }

   public void setNodeWeights(TreeNode excludedSubtree, int perspId){
        TreeSet<TreeNode> allVertices = getVertices();
        Iterator<TreeNode> it = allVertices.iterator();
        while(it.hasNext()){
            TreeNode treeNode = it.next();
            if(treeNode.getNodeName().equals(getObjectiveName())){
                node2WeightMap.put(perspId+"#"+treeNode.getSignature(), 1f);
                continue;
            }
            String signature = treeNode.getSignature();
            float value = node2EigenVecBasedWeightMapForSiblingInfo.get(perspId+"#"+signature);
            node2WeightMap.put(perspId+"#"+signature, value);
        }

        if(excludedSubtree!=null){
            node2WeightMap.put(perspId+"#"+excludedSubtree.getSignature(), 0f);
        }

        Iterator<TreeNode> allNodeIt = getVertices().iterator();
        while(allNodeIt.hasNext()){
            TreeNode treeNode = allNodeIt.next();
            float parentValue = node2WeightMap.get(perspId+"#"+treeNode.getSignature());
            TreeSet<TreeNode> succSet = getSuccessors(treeNode);
            Iterator<TreeNode> succNodeIt = succSet.iterator();
            while(succNodeIt.hasNext()){
                TreeNode succNode = succNodeIt.next();
                float succValue = node2WeightMap.get(perspId+"#"+succNode.getSignature());
                node2WeightMap.put(perspId+"#"+succNode.getSignature(), succValue*parentValue);
            }
        }

   }

   public float getNodeWeight(int perspId, TreeNode treeNode){
       return node2WeightMap.get(perspId+"#"+treeNode.getSignature());
   }

   public boolean get_visitedSiblingInfo(){
       return visitedSiblingInfo;
   }

   public void set_visitedSiblingInfo(){
       visitedSiblingInfo = true;
   }

   public void setCIThresholdForSiblingInfo(float CIThresholdForSiblingInfo){
       this.CIThresholdForSiblingInfo = CIThresholdForSiblingInfo;
   }

   public float getCIThresholdForSiblingInfo(){
       return CIThresholdForSiblingInfo;
   }



   public float getCIForSiblingInfo(int perspId, String signature){
       return CIMapForSiblingInfo.get(perspId+"#"+signature);
   }

   public float getLambdaMaxForSiblingInfo(int perspId, String signature){
       return lambdaMaxMapForSiblingInfo.get(perspId+"#"+signature);
   }


   public float getCIForQualMatrix(int perspId, String signature){
       return CIMapForQualMatrix.get(perspId+"#"+signature);
   }

   public float getLambdaMaxForQualMatrix(int perspId, String signature){
       return lambdaMaxMapForQualMatrix.get(perspId+"#"+signature);
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

   public void printData(){
       System.out.println("PRINTING ALL DATA STRUCTURES\n--------------------------\n");


       System.out.println("objectiveName=\n"+objectiveName);
       System.out.println("num_techs=\n"+num_techs);
       System.out.println("num_persp=\n"+num_persp);
       System.out.println("quantAttribTechEntry=\n"+quantAttribTechEntry);
       System.out.println("quantPerspAttribCostEntry=\n"+quantPerspAttribCostEntry);
       System.out.println("qualPerspAttribEntry=\n"+qualPerspAttribEntry);
       System.out.println("node2EigenVecBasedWeightMap=\n"+node2EigenVecBasedWeightMapForSiblingInfo);
       System.out.println("siblingPair2WeightMap=\n"+siblingPair2WeightMap);
       System.out.println("lambdaMaxMap=\n"+lambdaMaxMapForSiblingInfo);
       System.out.println("CIMap=\n"+CIMapForSiblingInfo);
       System.out.println("unexpandedNodeList=\n"+unexpandedNodeList);
       System.out.println("node2NeighbourMap=\n"+node2NeighbourMap);
       System.out.println("maxQuantAttribAcrossTechs=\n"+maxQuantAttribAcrossTechs);
       System.out.println("minQuantAttribAcrossTechs=\n"+minQuantAttribAcrossTechs);
   }

   public void writeData(){
       try {
            String directory = getWorkSpace()+"/"+getObjectiveName()+"/";
            File tempFile = new File(directory+"/objects.ser");
            tempFile.delete();
            File dirFile = new File(directory);
            dirFile.delete();
            dirFile.mkdirs();
            System.out.println("Filepath="+dirFile.getAbsolutePath());
            ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(directory+"/objects.ser"));

            out.reset();
            out.writeObject(objectiveName);

            out.writeObject(num_techs);
            out.writeObject(num_persp);

            out.writeObject(technologyNames);
            out.writeObject(perspNames);

            out.writeObject(quantAttribTechEntry);
            out.writeObject(quantPerspAttribCostEntry);

            out.writeObject(qualPerspAttribEntry);
            out.writeObject(node2EigenVecBasedWeightMapForQualMatrix);
            out.writeObject(lambdaMaxMapForQualMatrix);
            out.writeObject(CIMapForQualMatrix);


            out.writeObject(node2EigenVecBasedWeightMapForSiblingInfo);
            out.writeObject(siblingPair2WeightMap);
            out.writeObject(lambdaMaxMapForSiblingInfo);
            out.writeObject(CIMapForSiblingInfo);

            out.writeObject(unexpandedNodeList);

            out.writeObject(node2NeighbourMap);

            out.close(); // Also flushes output
        } catch(Exception e) {
            e.printStackTrace();
        }
   }


     public void readData(){
       try {
            String directory = getWorkSpace()+"/"+getObjectiveName()+"/";
            ObjectInputStream in = new ObjectInputStream(new FileInputStream(directory+"/objects.ser"));

            objectiveName = (String) in.readObject();

            num_techs = (Integer) in.readObject();
            num_persp = (Integer) in.readObject();

            technologyNames = (ArrayList<String>) in.readObject();
            perspNames = (ArrayList<String>) in.readObject();

            quantAttribTechEntry = (TreeMap<String,Float>) in.readObject();
            quantPerspAttribCostEntry = (TreeMap<String,Boolean>) in.readObject();

            qualPerspAttribEntry = (TreeMap<String,Float>) in.readObject();
            node2EigenVecBasedWeightMapForQualMatrix = (TreeMap<String,Float>) in.readObject();
            lambdaMaxMapForQualMatrix = (TreeMap<String,Float>) in.readObject();
            CIMapForQualMatrix = (TreeMap<String,Float>) in.readObject();

            node2EigenVecBasedWeightMapForSiblingInfo = (TreeMap<String,Float>) in.readObject();
            siblingPair2WeightMap = (TreeMap<String,Float>) in.readObject();
            lambdaMaxMapForSiblingInfo = (TreeMap<String,Float>) in.readObject();
            CIMapForSiblingInfo = (TreeMap<String,Float>) in.readObject();

            unexpandedNodeList = (ArrayList<TreeNode>) in.readObject();

            node2NeighbourMap = (TreeMap<TreeNode,TreeSet<TreeNode>>) in.readObject();

            //printGraph();
            Iterator<TreeNode> it = node2NeighbourMap.keySet().iterator();
            while(it.hasNext()){
                TreeNode parentNode = it.next();
                Iterator<TreeNode> succIt = node2NeighbourMap.get(parentNode).iterator();
                while(succIt.hasNext()){
                    TreeNode childNode = succIt.next();
                    addEdge(parentNode, childNode);
                }
            }
            //printGraph();

            in.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
   }

   public ArrayList rankTechnologies(int perspId){
       ArrayList resultList = new ArrayList();
       TreeMap<String,Float> valueMap = new TreeMap<String,Float>();
       resultList.add(valueMap);
       TreeMap<Float,TreeSet<Integer>> map = new TreeMap<Float,TreeSet<Integer>>();
       for(int techId=0; techId<getNumTechs(); techId++){
           float techWeight = 0;
           for(int attrId=0; attrId<numAttributes(); attrId++){
                TreeNode treeNode = getAttributeTreeNode(attrId);
                float value;
                if(treeNode.isQualitative()){
                    value = getQualAttrValue(perspId, treeNode, techId);
                }
                else{
                    value = getQuanAttrValue(perspId, treeNode, techId);
                }
                valueMap.put(treeNode.getSignature()+"#"+techId, value);
                techWeight+= value*getNodeWeight(perspId, treeNode);
            }
           if(map.containsKey(techWeight)){
               TreeSet<Integer> set = map.get(techWeight);
               set.add(techId);
           }
           else{
               TreeSet<Integer> set = new TreeSet<Integer> ();
               set.add(techId);
               map.put(techWeight, set);
           }
       }

       TreeMap<Integer,Float[]> tech2RankMap = new TreeMap<Integer,Float[]>();
       Iterator<Float> it = map.descendingKeySet().iterator();
       int rank = 1;
       while(it.hasNext()){
           float value = it.next();
           Iterator<Integer> techIt = map.get(value).iterator();
           while(techIt.hasNext()){
               int techId = techIt.next();
               Float[] valueANdRank = new Float[2]; valueANdRank[0]= value; valueANdRank[1] = (float) rank;
               tech2RankMap.put(techId,valueANdRank);
               rank++;
           }
       }
       resultList.add(tech2RankMap);
       return resultList;
   }
}