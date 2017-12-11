import scala.io.Source

def findRoot(list: String) : String = {
  val rootSet = collection.mutable.Set[String]()
  val leafSet = collection.mutable.Set[String]()

  for (program <- list.split("\n")) {
    if (program contains "->") {
      val nodes = program.split(" -> ")
      val root = nodes(0).split(" ")(0)
      val leaves = nodes(1).split(", ")

      rootSet += root
      for (leaf <- leaves) {
        leafSet += leaf
      }
    } else {
      rootSet += program.split(" ")(0)
    }
  }

  return (rootSet -- leafSet).toSeq.head
}

println("Running test")
val example = Source.fromFile("07/example.txt").mkString
val answer = findRoot(example)
if (answer == "tknk") {
  println("Test passed! Running on input.")
  println(s"Final answer: ${findRoot(Source.fromFile("07/input.txt").mkString)}")
} else {
  println(s"Test failed. Expected `tknk`, got $answer")
}
