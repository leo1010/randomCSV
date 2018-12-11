#!/usr/bin/env scala

import java.util.Date
import java.text.SimpleDateFormat

import scala.math.random
import scala.util.Random


case class Col(name: String, aType: String, enum: Array[String]) {

  val nEnum = enum.size

  def header() = name
  
  def rand() = aType match {
    case "string" =>       Random.alphanumeric.take(10).mkString
    case "float" =>        f"${math.random * 100}%2.2f"
    case "probability" =>  f"${math.random}%2.2f"
    case "date" =>         val dt = new Date(System.currentTimeMillis - (math.random * 1000 * 1000 * 1000).toLong )
                           val dt1 = new SimpleDateFormat("MM/dd/yyyy")
                           dt1.format(dt)
    case "id" =>           Random.alphanumeric.take(10).mkString
    case "enum" =>         enum(Random.nextInt(nEnum))
  }
}

object Col {

  def apply(spec: String): Col = {
    spec.split(":") match {      
      case Array(name, aType) =>        Col(name, aType.toLowerCase, Array())
      case Array(name, aType, enum) =>  Col(name, aType.toLowerCase, enum.split(","))
      case _ =>                         sys.error("error: " + spec)
    }
  }
}

	
val nRows = args.head.toInt
val cols = args.drop(1).map(Col(_))

println(nRows.toString)

println(cols.map(_.header()).mkString("\t"))

(1 to nRows).foreach(_ => println(cols.map(_.rand()).mkString("\t")))
