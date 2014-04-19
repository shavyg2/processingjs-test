resize=false

class Particle

  constructor:(@x,@y)->
    @_rotate=p.random(-30,30)
    @life=p.random(5000,5000)
    @initGravity=1
    @gravity=@initGravity
    @spread=10
    @xV= (p.random -@spread, @spread)
    @yV= (p.random -@spread, @spread)


  update:->
    if @y<=0
      @yV=0
    else if @y>p.height
      @y=p.height
      @xV=@xV*0.90
      @gravity=(parseInt -Math.floor Math.abs @gravity*0.7)
      @yV*=0.7

    @rotate+=@_rotate
    @life--
    @gravity+=@initGravity
    @y+= @gravity;
    @x+=@xV;
    @y+=@yV;
    if @x<=0
      @xV=-@xV*0.9
      @x=0
    else if @x>=p.width
      @xV=-@xV
      @x=p.width




  draw:->
    @type ?= @func()
    if @type is p.ellipse
      p.pushMatrix()
      p.translate(0,-image.width/2)

    else if @type is p.rect
      p.pushMatrix()
      p.translate(-25,-(image.width/2)-25)


    @type.call(p,@x,@y,50,50)
    p.popMatrix()

  drawImage:->
    if image.width>0
      p.pushMatrix()
      p.translate(-image.width/2,-image.height/2)

      p.pushMatrix()
      p.rotate(p.PI/2)
      p.popMatrix()
      p.popMatrix()

      p.pushMatrix()
      p.translate(-image.width/2,-image.height)
      p.image(image,@x,@y)
      p.popMatrix()


  resize:(factor=1)->
    unless resize
      image.resize(image.width/factor,image.height/factor)
      resize=true;



  type:null

  func:->
    opt=[p.ellipse,p.rect]
    num=Math.round(p.random(0,opt.length-1))
    opt[num]



####Functional Code

canvas= document.getElementById "tv"
p= new Processing canvas

particles=[]

p.draw=->
  p.fill(255,255,255,60)
  p.rect(0,0,p.width,p.height)

  if p.__mousePressed
    for i in [0...10]
      particles.push(new Particle p.mouseX, p.mouseY )


  while particles.length>500
    particles.shift()


  for particle in particles
    particle.update()
    particle.drawImage()
    particle.draw()

  newp=[]
  for particle in particles
    unless particle.life < 0
      newp.push(particle)

  particles=newp

image=p.requestImage("http://www.sierraclub.bc.ca/images/design-assets/twitter-icon")
image.resize(50,50)
p.size(document.body.clientWidth,document.body.clientHeight*0.9)
p.frameRate(30)
p.fill(255,255,255)
p.rect(0,0,p.width,p.height)
p.loop()

###
pText= Processing.toString().split("\n")

print=false;
max=1
more=max;
for line in pText
  if line.indexOf("p.mouse") > -1 or print
    unless print
      console.log  "_____________________________________________________________________________"
    console.log line
    print=true
    more--
  if more<=0
    print=false
    more=max
###