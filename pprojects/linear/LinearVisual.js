let matrix, startpointx, startpointy;

function setup(){
    createCanvas(640,360);
    matrix = new Matrix();
}

function draw(){
    background(255);

    matrix.update();
  //  matrix.rotateX(map(noise(this.x, this.y), 0, 1, -.3, .3));
  //  matrix.rotateY(map(noise(this.x, this.y), 0, 1, -.3, .3));
  //  matrix.rotateZ(map(noise(this.x, this.y), 0, 1, -.3, .3));
    matrix.display();
}

class Matrix{
    constructor(){
        this.mat = new Array(3);
        for(let r = 0; r < 3; r++){
            this.mat[r] = new Array(3);
            for(let c = 0; c < 3; c++)
                this.mat[r][c] = r == c ? 20 : 0;
        }
        this.x = 0; 
        this.y = 0;
    }
    display()
    {
        let dim = 3;
        
        for(let i = -1 * dim; i  <= dim; i++)
            for(let j = -1 * dim; j <= dim; j++)
                for(let k = -1 * dim; k <= dim; k++)
                {
                    let points = [[i, i + 1, i, i], [j, j, j + 1, j, 0], [k, k, k, k, k + 1], [0, 0, 0, 0]];
                    let points = new Array(3);
                    for(let r = 0; r < 3; r++){
                        points[r] = new Array(3);
                        for(let c = 0; c < 3; c++)
                            points[r][c] = r == c ? 20 : 0;
                    }
                    points = matMult

                    let n = 2; let r = width; let t = height;

                    for(let line = 1; line < points.length; line++)
                        if(line == 1 && i != dim || line == 2 && j != dim || line == 3 && k != dim)
                        {
                            if(j == 0 && i == 0 && k == 0)
                                stroke(line == 1 ? 255 : 0, line == 2 ? 255 : 0, line == 3 ? 255 : 0)
                                line(startpointx + points[0][0], startpointy - points[1][0], startpointx + points[0][line], startpointy - points[1][line]);
                        }
                }
    }
    rotateX(theta)
    {
        let rmat = [[1, 0, 0,0],[0, cos(theta), -sin(theta),0],[0, sin(theta), cos(theta),0],[0,0,0,1]];
        this.mat = matMult(rmat, this.mat);
    }
    rotateY(theta)
    {
        this.mat = [[cos(theta),0,sin(theta),0], [0, 1, 0,0], [-sin(theta), 0, cos(theta),1, 0], [0,0,0,1]];
        this.mat = matMult(rmat, mat);
    }

    rotateZ(theta)
    {
        mat = matMult(mat, [[cos(theta),sin(theta) * -1, 0,0],[sin(theta), cos(theta), 0,0],[0, 0, 1,0],[0,0,0,1]]);
    }
    update()
    {
        this.x += .01; 
        this.y += .01;
    }
}

function matMult(a, b) {
    var aNumRows = a.length, aNumCols = a[0].length,
        bNumRows = b.length, bNumCols = b[0].length,
        m = new Array(aNumRows);  // initialize array of rows
    for (var r = 0; r < aNumRows; ++r) {
      m[r] = new Array(bNumCols); // initialize the current row
      for (var c = 0; c < bNumCols; ++c) {
        m[r][c] = 0;             // initialize the current cell
        for (var i = 0; i < aNumCols; ++i) {
          m[r][c] += a[r][i] * b[i][c];
        }
      }
    }
    return m;
  }