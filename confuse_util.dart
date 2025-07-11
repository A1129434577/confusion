import 'dart:io';
import 'dart:math';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

void main() async {
  ///遍历lib文件夹下的所有.dart文件为其添加垃圾代码
  String projectPath = '/Users/liubin/Desktop/confusion_test_demo/';
  String libPath = '${projectPath}lib';
  Directory libDirectory = Directory(libPath);
  List<File> dartFileList = [];
  Future readFileRecursively(Directory directory) async {
    if (directory.existsSync()) {
      await for (var entity in directory.list()) {
        if (entity is Directory) {
          await readFileRecursively(entity);
        } else if (entity is File) {
          if(entity.path.endsWith('dart')) {
            dartFileList.add(entity);
          }
        }
      }
    }
  }
  await readFileRecursively(libDirectory);


  String scriptDirectoryPath = Platform.script.toFilePath();
  scriptDirectoryPath = scriptDirectoryPath.substring(0,scriptDirectoryPath.lastIndexOf(Platform.pathSeparator));
  ///获取垃圾代码列表（垃圾类）
  List<String> junkClassList = [];
  String junkClassPath = '${scriptDirectoryPath+Platform.pathSeparator}confuse_class.dart';
  List<String> junkClassCodeLines = File(junkClassPath).readAsLinesSync();
  String junkClassString = '';
  for(String line in junkClassCodeLines){
    if(line == '@pragma(\'vm:entry-point\')'){
      junkClassList.add(junkClassString);
      junkClassString = '';
    }
    junkClassString += '$line\n';
  }
  junkClassList.removeAt(0);

  ///获取垃圾代码列表（垃圾方法）
  List<String> junkMethodList = [];
  String junkMethodsPath = '${scriptDirectoryPath+Platform.pathSeparator}confuse_methods.dart';
  List<String> junkMethodCodeLines = File(junkMethodsPath).readAsLinesSync();
  String junkMethodString = '';
  for(String line in junkMethodCodeLines){
    if(line == '@pragma(\'vm:entry-point\')'){
      junkMethodList.add(junkMethodString);
      junkMethodString = '';
    }
    junkMethodString += '$line\n';
  }
  junkMethodList.removeAt(0);


  ///向目标.dart文件插入垃圾代码
  Random random = Random();
  for(File file in dartFileList){
    ///利用dart代码静态分析工具analyzer获取抽象语法树(AST)：
    ///找到可以添加垃圾代码的那一行代码申明：类声明的前面、方法申明的前面。
    List<String> targetClassLines = [];
    List<String> targetMethodLines = [];
    String fileCodeString = await file.readAsString();
    final parseResult = parseString(content: fileCodeString);
    final compilationUnit = parseResult.unit;
    // 遍历所有顶级声明
    for (final declaration in compilationUnit.declarations) {
      if (declaration is ClassDeclaration) {
        //发现类
        // print('    发现类: ${declaration.name}');
        String targetClassLine = fileCodeString.substring(declaration.classKeyword.charOffset, declaration.leftBracket.charEnd);
        targetClassLines.add(targetClassLine);
        // 遍历类成员
        for (final member in declaration.members) {
          if (member is MethodDeclaration) {
            //发现方法
            // print('    发现方法: ${member.name}');
            int? methodStart, methodEnd;
            if(member.modifierKeyword != null){
              methodStart = member.modifierKeyword!.offset;
            }
            else if(member.returnType != null){
              methodStart = member.returnType!.offset;
            }
            if(member.parameters != null){
              methodEnd = member.parameters!.rightParenthesis.charEnd;
            }

            if(methodStart!=null && methodEnd!=null){
              String targetMethodLine = fileCodeString.substring(methodStart, methodEnd);
              targetMethodLines.add(targetMethodLine);
            }
          }
        }
      } else if (declaration is FunctionDeclaration) {
        //发现顶级函数
        // print('发现顶级函数: ${declaration.name}');
      }
    }

    // print(targetClassLines.join('\n'));
    // print(targetMethodLines.join('\n'));

    //已经使用过的index(防止同一文件中植入相同类或方法)
    List<int> randomClassIndexList = [];
    List<int> randomMethodIndexList = [];
    ///再次遍历代码行，给具体行添加垃圾代码
    List<String> codeLines = file.readAsLinesSync();
    List<String> newCodeLines = [];
    for(String line in codeLines){
      int index = codeLines.indexOf(line);
      int previousIndex = index-1;
      if(previousIndex>-1 && (codeLines[previousIndex].contains('@')==false)){
        if(targetClassLines.contains(line.trim())){
          if(randomClassIndexList.length<junkClassList.length) {
            int randomIndex;
            do{
              randomIndex = random.nextInt(junkClassList.length);
            }while(randomClassIndexList.contains(randomIndex));
            randomClassIndexList.add(randomIndex);
            line = '${junkClassList[randomIndex]}$line';
          }
        }
        else {
          String tempLine = line.trim();
          int i = tempLine.lastIndexOf(')');
          if(i>-1) {
            String l = tempLine.substring(0, i+1);
            if (targetMethodLines.contains(l)) {
              if(randomMethodIndexList.length<junkMethodList.length) {
                int randomIndex;
                do{
                  randomIndex = random.nextInt(junkMethodList.length);
                }while(randomMethodIndexList.contains(randomIndex));
                randomMethodIndexList.add(randomIndex);
                line = '${junkMethodList[randomIndex]}$line';
              }
            }
          }
        }
      }
      newCodeLines.add(line);
    }
    ///重新写入文件
    file.writeAsStringSync(newCodeLines.join("\n"));
  }
}