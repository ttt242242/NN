# NN
My neural network sample

### 設定ファイルの生成

make_setting.rbに設定したい情報の入力  
* 入力層のノード数  
* 隠れ層の階層数
* 各階層のノード数
* 出力層の数
* リンクの設定
* しきい値の設定

を記述し、以下のコマンドを実行
```shell
ruby make_setting.rb

```


### 学習の実行

```shell
ruby NN.rb
```
