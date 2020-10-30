const drawille = require('drawille')
const bunny = require('bunny')
const glmatrix = require('gl-matrix')
const width = 200
const height = 200
const canvas = new drawille(width, height)
const mat4 = glmatrix.mat4
const vec3 = glmatrix.vec3

let points = []
bunny.cells.forEach(cell => {
  points.push(bunny.positions[cell[0]])
  points.push(bunny.positions[cell[1]])
  points.push(bunny.positions[cell[2]])
});

const project = mat4.create()
mat4.ortho(project, 200/-2, 200/2, 200/-2, 200/2, 0, 200)

function draw() {
  canvas.clear()

  const angle = +new Date()*0.001
  let mview = [
    Math.cos(angle),
    0,
    -Math.sin(angle),
    0,

    0,
    1,
    0,
    0,

    Math.sin(angle),
    0,
    Math.cos(angle),
    0,

    0,
    0,
    0,
    1
  ]
  
  const m = []
  mat4.mul(m, project, mview);

  points.forEach(point => {
    let o = []
    vec3.transformMat4(o, point, m)
    let x = ((o[0] * 8 + 1) * width)  /2
    let y = ((-o[1] * 8 + 1) * height)  /2

    canvas.set(x, y)
  });

  process.stdout.write(canvas.frame())
}

draw();

setInterval(draw, 16)