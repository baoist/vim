" Vim syntax file
" Language: volt
" Maintainer: Joshua Borton
" Credits: Tim Pope
" Filenames: *.volt

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'volt'
endif

runtime! syntax/html.vim
runtime! syntax/html/html5.vim
silent! syntax include @htmlCoffeescript syntax/coffee.vim
unlet! b:current_syntax
silent! syntax include @htmlStylus syntax/stylus.vim
unlet! b:current_syntax
silent! syntax include @htmlMarkdown syntax/markdown.vim
unlet! b:current_syntax

syn case match

syn region  javascriptParenthesisBlock start="(" end=")" contains=@htmlJavascript contained keepend
syn cluster htmlJavascript add=javascriptParenthesisBlock

syn region  voltJavascript matchgroup=voltJavascriptOutputChar start="[!&]\==\|\~" skip=",\s*$" end="$" contained contains=@htmlJavascript keepend
syn region  voltJavascript matchgroup=voltJavascriptChar start="-" skip=",\s*$" end="$" contained contains=@htmlJavascript keepend
syn cluster voltTop contains=voltBegin,voltComment,voltHtmlComment,voltJavascript
syn match   voltBegin "^\s*\%([<>]\|&[^=~ ]\)\@!" nextgroup=voltTag,voltClassChar,voltIdChar,voltPlainChar,voltJavascript,voltScriptConditional,voltScriptStatement
syn match   voltTag "+\?\w\+\%(:\w\+\)\=" contained contains=htmlTagName,htmlSpecialTagName nextgroup=@voltComponent
syn cluster voltComponent contains=voltAttributes,voltIdChar,voltBlockExpansionChar,voltClassChar,voltPlainChar,voltJavascript
syn match   voltComment '\s*\/\/.*$'
syn region  voltHtmlComment start="^\z(\s*\)/"  end="^\%(\z1\s\|\s*$\)\@!"
syn region  voltAttributes matchgroup=voltAttributesDelimiter start="(" end=")" contained contains=@htmlJavascript,voltHtmlArg,htmlArg,htmlEvent,htmlCssDefinition nextgroup=@voltComponent
syn match   voltClassChar "\." contained nextgroup=voltClass
syn match   voltBlockExpansionChar ":\s" contained nextgroup=voltTag
syn match   voltIdChar "#{\@!" contained nextgroup=voltId
syn match   voltClass "\%(\w\|-\)\+" contained nextgroup=@voltComponent
syn match   voltId "\%(\w\|-\)\+" contained nextgroup=@voltComponent
syn region  voltDocType start="^\s*\(!!!\|doctype\)" end="$"
" Unless I'm mistaken, syntax/html.vim requires
" that the = sign be present for these matches.
" This adds the matches back for volt.
syn keyword voltHtmlArg contained href title

syn match   voltPlainChar "\\" contained
syn region  voltInterpolation matchgroup=voltInterpolationDelimiter start="#{" end="}" contains=@htmlJavascript
syn match   voltInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"

syn region  voltJavascriptFilter matchgroup=voltFilter start="^\z(\s*\):javascript\s*$" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlJavascript
syn region  voltCoffeescriptFilter matchgroup=voltFilter start="^\z(\s*\):coffeescript\s*$" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlCoffeescript
syn region  voltMarkdownFilter matchgroup=voltFilter start=/^\z(\s*\):markdown\s*$/ end=/^\%(\z1\s\|\s*$\)\@!/ contains=@htmlMarkdown
syn region  voltStylusFilter matchgroup=voltFilter start="^\z(\s*\):stylus\s*$" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlStylus
syn region  voltPlainFilter matchgroup=voltFilter start="^\z(\s*\):\%(sass\|less\|cdata\)\s*$" end="^\%(\z1\s\|\s*$\)\@!"

syn match  voltScriptConditional "\<\%(if\|else\|unless\|while\|for\|until\)\>[?!]\@!"
syn match  voltScriptStatement "\<\%(each\|block\|append\|mixin\|extends\|include\)\>[?!]\@!"

syn region  voltJavascript start="^\z(\s*\)script\%(:\w\+\)\=" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlJavascript,voltJavascriptTag keepend 
syn region  voltJavascriptTag contained start="^\z(\s*\)script\%(:\w\+\)\=" end="$" contains=voltBegin,voltTag
syn region  voltCssBlock        start="^\z(\s*\)style" nextgroup=@voltComponent,voltError  end="^\%(\z1\s\|\s*$\)\@!" contains=@voltTop,@htmlCss keepend

syn match  voltError "\$" contained

hi def link voltPlainChar              Special
hi def link voltScriptConditional      PreProc
hi def link voltScriptStatement        PreProc
hi def link voltHtmlArg                htmlArg
hi def link voltAttributeString        String
hi def link voltAttributesDelimiter    Identifier
hi def link voltIdChar                 Special
hi def link voltClassChar              Special
hi def link voltBlockExpansionChar     Special
hi def link voltId                     Identifier
hi def link voltClass                  Type
hi def link voltInterpolationDelimiter Delimiter
hi def link voltFilter                 PreProc
hi def link voltDocType                PreProc
hi def link voltComment                Comment
hi def link voltHtmlComment            voltComment

let b:current_syntax = "volt"

if main_syntax == "volt"
  unlet main_syntax
endif
