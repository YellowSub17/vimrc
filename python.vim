

" Custom Python Highlighting 
" Save this in ~/.vim/after/syntax/python.vim


" Logic for match/case keywords 
syn match pythonCustomConditional /\%(match:\)\|\%(case:\)/
hi link pythonCustomConditional pythonConditional

" Reds (comments) 
highlight pythonComment      guifg=#994444

" Matrix green (strings) 
highlight pythonString       guifg=#19aa1c
highlight pythonFString      guifg=#19aa1c
highlight pythonQuotes       guifg=#19aa1c

" Light green (extra string stuff) 
highlight pythonBytesEscape  guifg=#88dd88
highlight pythonBytesContent guifg=#88dd88
highlight pythonStrFormat    guifg=#88dd88
highlight pythonRawString    guifg=#88dd88

" Blue (definitions) 
highlight pythonFunction     guifg=#2b83db
highlight pythonClass        guifg=#2b83db

" Cyan (calls & decorators) 
highlight pythonDecorator    guifg=#22eeee gui=bold
highlight pythonDottedName   guifg=#22eeee gui=bold
highlight pythonFunctionCall guifg=#22eeee

" Yellow (numbers) 
highlight pythonFloat        guifg=#efc402
highlight pythonNumber       guifg=#efc402

" Orange (keywords) 
highlight pythonBoolean      guifg=#c17228
highlight pythonNone         guifg=#c17228
highlight pythonOperator     guifg=#c17228
highlight pythonImport       guifg=#c17228
highlight pythonStatement    guifg=#c17228
highlight pythonRepeat       guifg=#c17228
highlight pythonConditional  guifg=#c17228
highlight pythonException    guifg=#c17228
highlight pythonExClass      guifg=#c17228

" Purple (builtins) 
highlight pythonBuiltinType  guifg=#9328c1
highlight pythonBuiltinFunc  guifg=#9328c1
highlight pythonInclude      guifg=#9328c1
highlight pythonBuiltin      guifg=#9328c1
highlight pythonBuiltinObj   guifg=#9328c1
highlight pythonClassVar     guifg=#9328c1


