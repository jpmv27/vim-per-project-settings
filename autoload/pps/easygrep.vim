let s:default_settings = {}

function! s:easygrep_file_path() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return ''
    endif

    return dir . '/easygrep.vim'
endfunction

function! pps#easygrep#edit() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return
    endif

    if !isdirectory(dir)
        echo 'You must create the project directory first'
        return
    endif

    let easygrep = s:easygrep_file_path()
    if easygrep ==# ''
        return
    endif

    execute 'split ' . easygrep
endfunction

function! pps#easygrep#apply() abort
    let easygrep = s:easygrep_file_path()

    if easygrep ==# ''
        return
    endif

    if !filereadable(easygrep)
        echo 'No settings to apply'
        return
    endif

    execute 'source' easygrep
endfunction

function! pps#easygrep#save_defaults() abort
    for [item, val] in items(g:)
        if match(item, 'EasyGrep[^_]') == 0
            let s:default_settings[item] = val
        endif
    endfor
endfunction

function! pps#easygrep#restore_defaults() abort
    for [item, val] in items(s:default_settings)
        let q = (type(val) == 1) ? "'" : ''
        execute 'let g:' . item . '=' . q . val . q
    endfor
endfunction

