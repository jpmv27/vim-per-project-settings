function! s:spell_dir_path() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return ''
    endif

    return dir . '/spell'
endfunction

function! s:spell_file_path() abort
    let dir = s:spell_dir_path()
    if dir ==# '' || !isdirectory(dir)
        return ''
    endif

    return dir . '/en.utf-8.add'
endfunction

function! pps#spell#init() abort
    " Since spellfile is updated cumulatively, need to reset it to
    " default before we add the per-project settings
    augroup pps_spell
        autocmd!
        execute 'autocmd BufEnter * :setlocal spellfile=' . &spellfile
    augroup END
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

function! pps#spell#make_dir() abort
    let dir = s:spell_dir_path()
    if dir ==# ''
        return
    endif

    if !isdirectory(dir)
        call mkdir(dir, 'p')
        echo 'Directory ' . dir . ' created, refresh file to update settings'
    else
        echo 'Directory ' . dir . ' already exists'
    endif
endfunction

function! pps#spell#remove_dir() abort
    let dir = s:spell_dir_path()
    if dir ==# ''
        return
    endif

    if isdirectory(dir)
        call delete(dir, 'rf')
        echo 'Directory ' . dir . ' removed, refresh file to update settings'
    else
        echo 'Directory ' . dir . " doesn't exist"
    endif
endfunction

