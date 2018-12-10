
case class Col(spec: String) {
	
}

object Main extends App {
	
  val n = args.take(1)
  val specs = args.drop(1)

  println(n.mkString)
  println(specs.mkString)
}
