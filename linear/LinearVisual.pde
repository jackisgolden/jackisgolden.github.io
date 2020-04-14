  float[][] unit = {{1,0,0},{0,1,0},{0,0,1}};
  //float[][] mat = {{20,0,0},{0,20,0},{0,0,20}};
  float[][] mat = {{20,0,0,0},{0,20,0,0},{0,0,20,0}, {0,0,0,1}};

  float startpointx, startpointy, thetaX, thetaY, thetaZ;
  
  public void setup() {    
    size(800, 800);
    startpointx = width/2; startpointy = height/2;
    thetaX = 0;
  }

  //public void setup() {
  //}

  public void draw() {        //don't know where else to put this, but in order for transformations to look better there needs to be a stack of matrices to transform and untransform
    background(0);            //order (right to left of matrix) should be scale, rotate, translate, render
    displayText();
    //transform();
    renderGraph();
  }
  public void displayText()
  {
    String s = "";
    for(int i = 0; i < mat.length; i++)
    {
      s += "| ";
      for(int j = 0; j < mat.length; j++)
        s+= "" + (mat[i][j]) + ", ";
      s+= "|\n";
    }
    //text(s, width/2, height/8);
    text(s, 20, 20);
  }
  
  public void transform()
  {
   // mat = rotateMatX(mat, thetaX);
  }
  public void renderGraph()
  {
    int dim = 3;                                       //order of operations(right to left): scale, rotate, shift, project
       for(int i = -1 * dim; i <= dim; i++)            //3D RENDER, ORTHOGRAPHIC PROJECTION
        for(int j = -1 * dim; j <= dim; j++)
        for(int k = -1 * dim; k <= dim; k++)            //let z at k = 0 be 2
        {
           //float[][] points = {{i, j, k, 0}, { i + 1, j, k, 0}, { i,  j + 1, k, 0}, {i, j, k + 1,0}}; //homogenous matrix
           float[][] points = {{i, i + 1,i,i},{j, j, j + 1, j, 0},{k,k,k,k+1},{0,0,0,0}};
           //points = matTranspose(points);
           points = matMult(mat, points);
           //float[][] project = {{1/(10 + 10*k),0,0,0},{0,1/(10 + 10*k),0,0},{0,0,0,0}, {0,0,-1/(10*k + 10),1}};
           //points = matMult(project,points);
           
           float n = 20; float r = width; float t = height;
           //float[][] projPerspective = {{20,0,0,0},{0,20,0,0},{0,0,(k+ 20)/(20- k), 2*k*20/(20-k)},{0,0, -1, 0}}; //3,2 is our divide factor
           //points = matMult(projPerspective, points);
           
           stroke(255);
           for(int line = 1; line < points.length ; line++)
             if(line == 1 && i !=dim || line == 2 && j != dim || line == 3 && k != dim)
             {
               if(j == 0 && i == 0 && k ==0)
                 stroke(line == 1 ? 255 : 0, line == 2 ? 255: 0, line == 3 ? 255 : 0);
              line(startpointx + points[0][0], startpointy - points[1][0], startpointx + points[0][line], startpointy - points[1][line]);
             }
      }
      
      //for(int i = -10; i <= 10; i++)            //2D RENDER
      //  for(int j = -10; j <= 10; j++)
      //  {
      //     float[][] points = {{i,j,1},{ i + 1, j, 1}, { i,  j + 1, 1}};
      //     points = matTranspose(points);
      //     points = matMult(mat, points);
           
      //     stroke(255);
      //     for(int line = 1; line < points.length ; line++)
      //       if(line == 1 && i !=10 || line == 2 && j != 10)
      //       {
      //         if(j == 0 && i == 0)
      //           stroke(line == 1 ? 255 : 0, line == 2 ? 255: 0, 0);
      //        line(startpointx + points[0][0], startpointy - points[1][0], startpointx + points[0][line], startpointy - points[1][line]);
      //       }
      //}
  }
  
  public float[][] matMult(float[][] mat1, float[][] mat2)
  {
    //if(mat1[0].length != mat2.length)
     // System.out.println("Invalid DIM!");
    float[][] product = new float[mat1.length][mat2[0].length];
        for (int i = 0; i < mat1.length; i++)
            for (int j = 0; j < mat2[0].length; j++)
                for (int k = 0; k < mat1[0].length; k++)
                    product[i][j] += mat1[i][k] * mat2[k][j];
    return product;
  }
  public float[] matMult(float[][] mat1, float[] mat2) //Ax = B
  {
    if(mat1[0].length != mat2.length)
      System.out.println("invalid DIM");
      float[] product = new float[mat2.length];
      for(int i = 0; i < product.length; i++)
        for(int j = 0; j < mat1[0].length; j++)
          product[i] += mat1[i][j] * mat2[i];
    return product;
  }
  
  public float[][] matTranspose(float[][]mat1)
  {
    float[][] transposed = new float[mat1.length][mat1[0].length];
    for(int r = 0; r < mat1.length; r++)
      for(int c = 0; c < mat1[0].length; c++)
        transposed[r][c] = mat1[c][r];
    return transposed;
  }
  
  public float[][] rotateMatZ(float theta)
  {
    float[][] rotMat = {{cos(theta),sin(theta) * -1, 0,0},{sin(theta), cos(theta), 0,0},{0, 0, 1,0},{0,0,0,1}};
    return matMult(rotMat, mat);
  }
  
    public float[][] rotateMatX(float[][] m, float theta)
  {
    float[][] rotMat = {{1, 0, 0,0},{0, cos(theta), -sin(theta),0},{0, sin(theta), cos(theta),0},{0,0,0,1}};
    return matMult(rotMat, m);
  }
  
  public float[][] rotateMatY(float[][] m, float theta)
  {
    float[][] rotMat = {{cos(theta),0,sin(theta),0}, {0, 1, 0,0}, {-sin(theta), 0, cos(theta),1, 0}, {0,0,0,1}};
    return matMult(rotMat, m);
  }
  
  public void keyPressed()
  {
    if(key == 't')
      mat = matTranspose(mat);
    else if(key == 'r')
    {
      float[][] m = {{20,0,0,0},{0,20,0,0},{0,0,20,0}, {0,0,0,1}};
      mat = m;
    }
    else if(keyCode == LEFT)
      mat = rotateMatZ(0.04);
    else if(keyCode == RIGHT)
       mat = rotateMatZ(-.04);
    else if(keyCode == UP)
      mat = rotateMatX(mat, .04);
    else if(keyCode == DOWN)
       mat = rotateMatX(mat, -.04);
           else if(key == ';')
      mat = rotateMatY(mat, -.04);
    else if(key == '\'')
       mat = rotateMatY(mat, .04);
    else if(key == 'w')
      mat = translateMat(mat, 0, 1, 0);
    else if(key == 'a')
      mat = translateMat(mat, -1, 0, 0);
    else if(key == 's')
      mat = translateMat(mat, 0, -1, 0);
    else if(key == 'd')
      mat = translateMat(mat, 1, 0, 0);
    else if(key == '.')
        {
          float[][] m = {{1.1,0,0, 0},{0,1.1,0, 0},{0,0,1.1, 0}, {0, 0, 0, 1}};
          mat = matMult(m,mat);
        }
        else if(key == ',')
        {
          float[][] m = {{0.9,0,0,0},{0,0.9,0,0},{0,0,0.9,0},{0,0,0,1}};
          mat = matMult(m,mat);
        }
     else if(key == 'i')
         mat = invertMat(mat);
     else if(key == 'v') //det
         System.out.println(detMat(mat) + "");
  }
  
  public float[][] translateMat(float[][] m, float dx, float dy, float dz)
  {
    float[][] m1 = m;
    //float[][] m2 = new float[m.length + 1][m[0].length + 1];
    //for(int i = 0; i < m.length; i++)
    //  for(int j = 0; i < m[0].length; j++)
    //      m1[i][j] = m[i][j];                               //this doesnt work for some reason
    float[][] m2 = {{1,0,0,dx},{0,1, 0, dy}, {0,0,1,dz},{0,0,0,1}};
    float[][] m3 = matMult(m2, m);
    //float[][] m4 = new float[m.length][m.length];          //now we shrink the oversized matrix back down
    //for(int i = 0; i < m4.length; i++)
    //  for(int j = 0; j < m4[0].length; j++)
    //    m4[i][j] = m3[i][j];
    return m3;
  }
  public float[][] invertMat(float[][] m)
  {
    //if(detMat(m) == 0)
     // return null;
    float[][]a = new float[m.length][m[0].length *2];
    for( int i = 0; i < a.length; i++)
      for(int j = 0; j <a[0].length; j++)
        if(j <m.length)
          a[i][j] = m[i][j];
          else if( i == (j - m[0].length))
          a[i][j] = 1;
    a = rref(a);
    float[][] b = new float[m.length][m[0].length];
    for(int i = 0; i < b.length; i++)
      for(int j = 0; j < b[0].length; j++)
        b[i][j] = a[i][j + m[0].length];
    return b;
  }
  public float detMat(float[][]m)
  {
    if(m.length == 2){
      System.out.println("reached the final state");
      return m[0][0]*m[1][1] - m[0][1]*m[1][0];}
    float det = 0;
    for(int j = 0; j < m[0].length; j++)
      det += m[0][j] * detMat(shrinkMat(m, j));
     return det;
  }
  public float[][] shrinkMat(float[][]m, int index) //shrink the matrix in determinant fashion, append matrix in modular fashion
  {
    float[][] a = new float[m.length - 1][m[0].length - 1];
    for(int i = 0; i < a.length; i++)
      for(int j = 0; j < a[0].length; j++)
         a[i][j] = m[i + 1 ][(j + 1 + index) % m[0].length];
    return a;
  }
  public float[] project3DMat(float[] p, float[][]m)
  {
    float d, fov;
    fov = PI/2;
    d = 1/(tan(fov/2));
    
    float[][] expand = new float[m.length + 1][m[0].length + 1];
    for(int i = 0; i < m.length; i++)
      for(int j = 0; j < m[0].length; j++)
        expand[i][j] = m[i][j];
     expand[3][2] = -1;
        
     float[][] proj3d = {{100/20, 0, 0, 0},{0, 100/20, 0, 0},{0,0,(p[2] + 100)/(100-p[2]), (2*p[2]*100) / (100 - p[2])},{0,0,-1,0}};
    
    return matMult(expand, p);
  }
  
  
  static public float[][] rref(float [][] m)
  {  
    int lead = 0;
    int rowCount = m.length;
    int colCount = m[0].length;
    int i;
    boolean quit = false;

    for(int row = 0; row < rowCount && !quit; row++)
    {
        if(colCount <= lead)
        {
            quit = true;
            break;
        }
        i=row;
        while(!quit && m[i][lead] == 0)
        {
            i++;
            if(rowCount == i)
            {
                i=row;
                lead++;

                if(colCount == lead)
                {
                   quit = true;
                    break;
                }
            }
        }
        if(!quit)
        {
            swapRows(m, i, row);

            if(m[row][lead] != 0)
                multiplyRow(m, row, 1.0f / m[row][lead]);

            for(i = 0; i < rowCount; i++)
            {
                if(i != row)
                    subtractRows(m, m[i][lead], row, i);
            }
        }
      }
    return m;
    }

// swaps two rows
static void swapRows(float [][] m, int row1, int row2)
{
    float [] swap = new float[m[0].length];

    for(int c1 = 0; c1 < m[0].length; c1++)
        swap[c1] = m[row1][c1];

    for(int c1 = 0; c1 < m[0].length; c1++)
    {
        m[row1][c1] = m[row2][c1];
        m[row2][c1] = swap[c1];
    }
}

static void multiplyRow(float [][] m, int row, float scalar)
{
    for(int c1 = 0; c1 < m[0].length; c1++)
        m[row][c1] *= scalar;
}

static void subtractRows(float [][] m, float scalar, int subtract_scalar_times_this_row, int from_this_row)
{
    for(int c1 = 0; c1 < m[0].length; c1++)
        m[from_this_row][c1] -= scalar * m[subtract_scalar_times_this_row][c1];
}
