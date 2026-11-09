" vim-jp: Vimで使っている簡単キーマッピングたちを共有
" https://zenn.dev/vim_jp/articles/43d021f461f3a4

" Yを行末までのヤンクにする
nnoremap Y y$

" xをブラックホールレジスタを使う削除オペレータにする
nnoremap x "_d
nnoremap X "_D
xnoremap x "_x
onoremap x d

" i<Space>でWORDを選択
onoremap i<Space> iW
xnoremap i<Space> iW

" Uでリドゥ
nnoremap U <C-r>

" matchitで括弧やブロックの対応箇所へ移動
silent! packadd matchit
map <expr> M expand('<cword>') =~# 'end' ? '%' : 'g%'

" qレジスタだけをマクロ用にし、qをプレフィックスとして使う
nnoremap <script><expr> q empty(reg_recording()) ? '<sid>(q)' : 'q'
nnoremap <sid>(q)q qq
nnoremap <script><expr> Q empty(reg_recording()) ? '@q' : 'q@q'
nnoremap <sid>(q)o <Cmd>only!<CR>
nnoremap <sid>(q)t <C-^>
nnoremap <sid>(q)g :<C-u>global/^/normal<Space>
xnoremap qg :global/^/normal<Space>

" Visual yank後にカーソル位置を復元
xnoremap y mzy`z

" Visual pasteでレジスタを維持
xnoremap p P

" Visualのインデント操作後も選択範囲を維持
xnoremap < <gv
xnoremap > >gv

" 行を上下に移動
nnoremap <expr> <C-k> '<Cmd>move-1-'.v:count1.'<CR>=l'
nnoremap <expr> <C-j> '<Cmd>move+'.v:count1.'<CR>=l'
xnoremap <silent><C-k> :move'<-2<CR>gv=gv
xnoremap <silent><C-j> :move'>+1<CR>gv=gv

" 行を上下に複製
nnoremap <Space>g <Cmd>copy.<CR>
nnoremap <Space>G <Cmd>copy-1<CR>
xnoremap <Space>g :copy'<-1<CR>gv
xnoremap <Space>G :copy'>+0<CR>gv

" 空行で編集を始めるときは周囲のインデントを引き継ぐ
nnoremap <expr> i empty(getline('.')) ? '"_cc' : 'i'
nnoremap <expr> A empty(getline('.')) ? '"_cc' : 'A'

" Insert modeで直前のwordの大文字・小文字を切り替える
inoremap <C-g><C-u> <Esc>gUiwgi
inoremap <C-g><C-l> <Esc>guiwgi
inoremap <C-g><C-k> <Esc>bgUlgi

" /はvery magic、?はvery nomagicで検索開始
nnoremap / /\v
nnoremap ? ?\V

" カーソル下またはVisual選択範囲を置換
nnoremap S :%s/\V\<<C-r><C-w>\>//g<Left><Left>
xnoremap S "zy:%s/\V<C-r><C-r>=escape(@z,'/\')<CR>//gce<Left><Left><Left><Left>

" ペースト先のインデントを揃え、ペースト範囲末尾にカーソルを置く
nnoremap p ]p`]
nnoremap P ]P`]

" 直前のペースト範囲を選択
noremap gV `[v`]

" 直前・直後の空行へ移動
nnoremap F<CR> {
nnoremap f<CR> }

" 現在のバッファのgit diffを表示
command! GitDiff
      \ new
      \ | setlocal buftype=nofile bufhidden=delete noswapfile
      \ | setfiletype gitcommit
      \ | execute 'read !git diff #'
      \ | setlocal readonly nobuflisted
      \ | normal! gg
nnoremap ds <Cmd>GitDiff<CR>
