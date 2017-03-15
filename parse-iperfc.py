import os

fileDir = "logs/iperfc"
for parseFile in os.listdir(fileDir):
    if parseFile.endswith(".log"):
        print parseFile

        parsedFile = "parsed-%s" % parseFile
        with open(fileDir+"/"+parseFile,'r') as rHandle:
            with open(fileDir+"/parsed/"+parsedFile,'w') as wHandle:
                newLine = ""
                prep = 0
                index = 0
                for line in rHandle:
                    if line == "------------------------------------------------------------\n":
                        prep += 1

                    if prep == 2:
                        if index != 0 and index % 3 == 0:
                            lineArray = line.split()
                            interval = lineArray[2]
                            transmitTime = interval.split('-')[1]

                            transmitAmount = lineArray[4]
                            transmitRate = lineArray[6]
                            newLine = newLine + transmitTime + "\t" + transmitAmount + "\t" + transmitRate + "\t"

                        if index != 0 and index % 4 == 0:
                            datagrams = line.split()[3]
                            newLine = newLine + datagrams + "\t"

                        index += 1

                    if prep == 3:
                        prep = 1
                        index = 0
                        newLine = newLine + '\n'
                        wHandle.write(newLine)
                        newLine = ""
                newLine += "\n"
                #print newLine
                wHandle.write(newLine)
                newLine = ""
