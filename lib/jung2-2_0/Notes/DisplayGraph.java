
package iitb.ctara.ahp;

import edu.uci.ics.jung.algorithms.layout.CircleLayout;
import edu.uci.ics.jung.algorithms.layout.Layout;
import edu.uci.ics.jung.graph.DirectedSparseGraph;
import edu.uci.ics.jung.graph.Graph;
import edu.uci.ics.jung.visualization.BasicVisualizationServer;
import java.awt.Dimension;
import javax.swing.JFrame;

public class DisplayGraph {
public static void main(String[] args) {

    Graph<Integer, String> g = (Graph)new DirectedSparseGraph<TreeNode,TreeEdge>();
    g.addVertex((Integer)1);
    g.addVertex((Integer)2);
    g.addVertex((Integer)3);
    g.addEdge("Edge-A", 1, 2); // Note that Java 1.5 auto-boxes primitives
    g.addEdge("Edge-B", 2, 3);
    System.out.println("The graph g = " + g.toString());

    Layout<Integer, String> layout = new CircleLayout(g);
    layout.setSize(new Dimension(300,300)); // sets the initial size of the space
    // The BasicVisualizationServer<V,E> is parameterized by the edge types
    BasicVisualizationServer<Integer,String> vv =
    new BasicVisualizationServer<Integer,String>(layout);
    vv.setPreferredSize(new Dimension(350,350)); //Sets the viewing area size
    JFrame frame = new JFrame("AHP Graph");
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.getContentPane().add(vv);
    frame.pack();
    frame.setVisible(true);
    }
}