 float[][] mat = {{40,0,0,0},{0,40,0,0},{0,0,40,0}, {0,0,0,1}};
  float startpointx, startpointy;
 boolean perlin;
 float x, y;
  
  public void setup() {    
    size(800, 800);
    startpointx = width/2; startpointy = height/2;
    background(0);
    perlin = true;
    x = 0; y = 0;
  }
  public void draw() {
    background(255);
    if(perlin)
      perlinRotate();
    renderGraph();
  }
  public void renderGraph()
  {
    int dim = 3;
    for(int i = -1 * dim; i <= dim; i++){
      for(int j = -1 * dim; j <= dim; j++){
        for(int k = -1 * dim; k <= dim; k++)
        {
           float[][] points = {{i, i + 1,i,i},{j, j, j + 1, j, 0},{k,k,k,k+1},{0,0,0,0}};
           points = matMult(mat, points);
           float n = 20; float r = width; float t = height;
           stroke(185,103,255);
           for(int l = 1; l < points.length ; l++){
             if(l == 1 && i !=dim || l == 2 && j != dim || l == 3 && k != dim)
             {
               if(j == 0 && i == 0 && k ==0)
                 stroke(l == 1 ? 255 : 0, l == 2 ? 255: 0, l == 3 ? 255 : 0);
              line(startpointx + points[0][0], startpointy - points[1][0], startpointx + points[0][l], startpointy - points[1][l]);
             }
           }
        }
      }
    }
  }
  
  public float[][] matMult(float[][] mat1, float[][] mat2)
  {
    float[][] product = new float[mat1.length][mat2[0].length];
        for (int i = 0; i < mat1.length; i++)
            for (int j = 0; j < mat2[0].length; j++)
                for (int k = 0; k < mat1[0].length; k++)
                    product[i][j] += mat1[i][k] * mat2[k][j];
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
  public float[][] rotateMatZ(float[][] m, float theta)
  {
    float[][] rotMat = {{cos(theta),sin(theta) * -1, 0,0},{sin(theta), cos(theta), 0,0},{0, 0, 1,0},{0,0,0,1}};
    return matMult(rotMat, m);
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
  public void perlinRotate()
  {
    x += .01;
    y += .01;
    mat = rotateMatX(mat, map(noise(x,y),0,1,-.04,.04));
    mat = rotateMatY(mat, map(noise(y + 30, x + 30),0,1,-.04,.04));
    mat = rotateMatZ(mat, map(noise(x - 30,y - 30),0,1,-.04,.04));
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
      mat = rotateMatZ(mat, 0.04);
    else if(keyCode == RIGHT)
       mat = rotateMatZ(mat, -.04);
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
    else if(key == 'p')
      perlin = !perlin;
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
  }