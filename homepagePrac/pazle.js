window.onload = function() {

    function init() {
        var arr = ['']
        for(i = 0; i < 8; i++) {
            arr.push((i + 1).toString());
        }
        shuffle(arr);
        if(!isSolved(arr.slice(0, arr.length))) { 
            init();
        }else {
            render(arr);
        }
    }

    // 配列シャッフル用関数
    function shuffle(arr) {
        var i = arr.length;
        while(i) {
            // 0 ~ 最大8までの乱数を生成
            var j = Math.floor(Math.random() * i--);
            swap(i, j, arr);
        }
    }

    // 配列の値入れ替え用関数
    function swap(i, j, arr) {
        var tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
    }

    // 解決可能なパズルかを判定する関数
    function isSolved(arr) {
        var blank_index = arr.indexOf('');
        dist_vertical = Math.floor(((arr.length - 1) - blank_index) / Math.sqrt(arr.length));
        dist_horizontal = ((arr.length - 1) - blank_index) % Math.sqrt(arr.length);
        var dist = dist_vertical + dist_horizontal;

        answer = [];
        for(i = 0; i < 8; i++) {
            answer.push((i + 1).toString());
        }
        answer.push('');

        var count = 0;
        for (var i = 0; i < answer.length; i++) {
            for (var j = i + 1; j < answer.length; j++) {
                // 要素番号＋1の数が格納されている箇所と入れ替える
                if(i + 1 == arr[j]) { 
                    swap(i, j, arr);
                    // 入れ替えが起きたら1プラスする
                    count++;
                }
            }
            // 答えの配列と同じになったかどうかを判定
            if(arr.toString() === answer.toString()) {
                break;
            }
        }

        // 判定処理
        if(count % 2 === dist % 2) { 
            return true;
        }else { 
            return false;
        }
    }

    // パズル描画用関数
    function render(arr) {
        var $jsShowPanel = document.getElementById('js-show-panel');
        // すでにパズルが描画されていたら、それらを一旦削除する
        while($jsShowPanel.firstChild) {
            $jsShowPanel.removeChild($jsShowPanel.firstChild);
        }

        // フラグメント生成
        fragment = document.createDocumentFragment();

        arr.forEach(function(element) {   
            var tileWrapper = document.createElement('div');
            tileWrapper.className = 'tile-wrapper';

            var tile = document.createElement('div');
            tile.className = element != '' ? 'tile tile-' + element : 'tile tile-none';
            tile.textContent = element;

            tileWrapper.appendChild(tile);
            fragment.appendChild(tileWrapper);
        });
        // 描画
        $jsShowPanel.appendChild(fragment);
        // クリックイベントを追加
        addEventListenerClick(arr);
    }

    // パズルをクリックイベント追加用関数
    function addEventListenerClick(arr) {

        $tile = document.querySelectorAll('.tile');
        $tile.forEach(function(elem) {
            elem.addEventListener('click', function() {
                var i =  arr.indexOf(this.textContent);
 
                var j;

                if(i <= 5 && arr[i + 3] == '') {
                    // 下方向へ移動
                    j = i + 3;
                }
                // パズルが下2行かつクリックパズルの上のマスが空白なら
                else if(i >= 3 && arr[i - 3] == '') {
                    // 上方向へ移動
                    j = i - 3;

                }
                // パズルが左2列かつクリックパズルの右のマスが空白なら
                else if(i % 3 != 2 && arr[i + 1] == '') {
                    // 右方向へ移動
                    j = i + 1;
                // パズルが右2列かつクリックパズルの左のマスが空白ならら
                }else if(i % 3 != 0 && arr[i - 1] == '') {
                    // 左方向へ移動
                    j = i - 1;
                }
                // クリックされたパズルが移動させられなかったら
                else {
                    return;
                }
                // パズルを移動
                swap(i, j, arr);
                // パズルを再描画
                render(arr);
            });
        });
    }

    init();
    // パズルのリセット
    document.getElementById('js-reset-puzzle').addEventListener('click', function() {
        init();
    });
}