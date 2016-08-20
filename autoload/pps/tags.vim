function s:tags_file_path() abort
    return b:pps_project_dir . '/tags'
endfunction

function s:ctags_cmd_base() abort
    let cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q '

    if get(b:, 'pps_tags_recurse_dirs')
        let cmd .= '-R '
    endif

    return cmd
endfunction

function pps#tags#configure(activate) abort
    let activate = a:activate

    if activate
        let tags = s:tags_file_path()

        if !filereadable(tags)
            let activate = 0
        endif
    endif

    if activate
        let b:pps_tags_file = tags
        execute 'setlocal tags=' . tags

        augroup pps_tags
            autocmd!
            autocmd BufWritePost *.cpp,*.h,*.c call pps#tags#update_one()
        augroup END
    else
        if exists('b:pps_tags_file')
            unlet b:pps_tags_file
        endif
    endif
endfunction

function pps#tags#update() abort
    if !exists('b:pps_project_dir')
        echo 'No project directory'
        return
    endif

    let cmd = s:ctags_cmd_base() . '-f ' . s:tags_file_path() . ' '

    for d in get(b:, 'pps_tags_subdirs', [''])
        let cmd .= simplify(fnameescape(getcwd() . '/' . d) . '/*') . ' '
    endfor

    let log = system(cmd)
    if v:shell_error == 0
        echo 'Tags file updated'
        call pps#tags#configure(1)
    else
        echo 'Updating failed with exit status' v:shell_error
        echo cmd
        echo log
    endif
endfunction

function pps#tags#update_one() abort
    if !exists('b:pps_tags_file')
        return
    endif

    let tags = b:pps_tags_file
    let temp = tags . '.tmp'

    let file = resolve(fnameescape(expand('%:p')))
    let path = fnamemodify(file, ':h')

    let matched = 0
    for d in get(b:, 'pps_tags_subdirs', [''])
        let ppath = resolve(fnameescape(getcwd() . '/' . d))
        if (path == ppath)
            let matched = 1
        endif
    endfor

    if !matched
        return
    endif

    let cmd = 'sed "/' . escape(file, './') . '/d" ' . tags . ' > ' . temp
    let cmd .= '; ' . s:ctags_cmd_base() . '-a -f ' . temp . ' ' . file
    let cmd .= '; mv ' . temp . ' ' . tags

    let log = system(cmd)
    if v:shell_error == 0
        echo 'Tags file updated'
    else
        echo 'Updating failed with exit status' v:shell_error
        echo cmd
        echo log
    endif
endfunction

