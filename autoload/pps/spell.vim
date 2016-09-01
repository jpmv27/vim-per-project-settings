function! s:spell_file_path() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return ''
    endif

    return dir . '/en.utf-8.add'
endfunction

function! pps#spell#configure(active) abort
    if !exists('g:pps_common_spellfile')
        return
    endif

    let active = a:active

    if active
        let spell = s:spell_file_path()
        if spell ==# ''
            let active = 0
        endif
    endif

    if active
        execute 'setlocal spellfile=' . g:pps_common_spellfile . ',' . spell
    else
        execute 'setlocal spellfile=' . g:pps_common_spellfile
    endif
endfunction

