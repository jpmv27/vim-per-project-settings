function! s:spell_file_path() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return ''
    endif

    let dir = dir . '/spell'
    if !isdirectory(dir)
        return ''
    endif

    return dir . '/en.utf-8.add'
endfunction

function! pps#spell#configure(active) abort
    let active = a:active

    if active
        let spell = s:spell_file_path()
        if spell ==# ''
            let active = 0
        endif
    endif

    if active
        execute 'setlocal spellfile=' . &spellfile . ',' . spell
    else
    endif
endfunction

