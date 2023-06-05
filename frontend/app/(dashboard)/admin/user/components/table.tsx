import { useState } from 'react';
import { getCoreRowModel, useReactTable, flexRender, getPaginationRowModel, getFilteredRowModel, FilterFn} from '@tanstack/react-table';
import type { ColumnDef } from '@tanstack/react-table';
import { filterFns } from './filterFn';
import { DebouncedInput } from './debouncedInput';

interface ReactTableProps<T extends object> {
 data: T[];
 columns: ColumnDef<T>[];
 showFooter: boolean;
 showNavigation?: boolean;
 showGlobalFilter?: boolean;
 filterFn?: FilterFn<T>;
}

export const Table = <T extends object>({ 
  data, 
  columns, 
  showFooter = true, 
  showNavigation = true, 
  showGlobalFilter = false,
  filterFn = filterFns.fuzzy,
}: ReactTableProps<T>) => {
  const [globalFilter, setGlobalFilter] = useState('');
  const table = useReactTable({
    data,
    columns,
    state: {
      globalFilter
    },
    getCoreRowModel: getCoreRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    onGlobalFilterChange: setGlobalFilter,
    globalFilterFn: filterFn,
  });

 return (
   <div className="gap-4">
      {showGlobalFilter ? (
        <DebouncedInput
          value={globalFilter ?? ''}
          onChange={(value) => setGlobalFilter(String(value))}
          className="input input-bordered input-md w-full max-w-xs"
          placeholder="Search all columns..."
        />
      ) : null}
      <table className="table w-full mt-4 text-base-content [&_tbody_*]:bg-white [&_thead_*]:bg-base-300">
        <thead className="">
          {table.getHeaderGroups().map((headerGroup) => (
            <tr key={headerGroup.id}>
              {headerGroup.headers.map((header) => (
                <th key={header.id} className="px-6 py-4 text-sm font-medium text-gray-900">
                  {header.isPlaceholder ? null : flexRender(header.column.columnDef.header, header.getContext())}
                </th>
              ))}
            </tr>
          ))}
        </thead>
        <tbody>
          {table.getRowModel().rows.map((row) => (
            <tr key={row.id} className='border-b" bg-white'>
              {row.getVisibleCells().map((cell) => (
                <td className="whitespace-nowrap px-6 py-4 text-sm font-light text-gray-900" key={cell.id}>
                  {flexRender(cell.column.columnDef.cell, cell.getContext())}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
        {showFooter ? (
          <tfoot className="border-t bg-gray-50">
            {table.getFooterGroups().map((footerGroup) => (
              <tr key={footerGroup.id}>
                {footerGroup.headers.map((header) => (
                  <th key={header.id} colSpan={header.colSpan}>
                    {header.isPlaceholder
                      ? null
                      : flexRender(header.column.columnDef.footer, header.getContext())}
                  </th>
                ))}
              </tr>
            ))}
          </tfoot>
        ) : null}
      </table>
      {showNavigation ? (
        <>
          <div className="h-2 mt-5" />
          <div className="btn-group">
            <button
              className="btn"
              onClick={() => table.setPageIndex(0)}
              disabled={!table.getCanPreviousPage()}
            >
              {'<<'}
            </button>
            <button
              className="btn"
              onClick={() => table.previousPage()}
              disabled={!table.getCanPreviousPage()}
            >
              {'<'}
            </button>
            <button
              className="btn"
              onClick={() => table.nextPage()}
              disabled={!table.getCanNextPage()}
            >
              {'>'}
            </button>
            <button
              className="btn"
              onClick={() => table.setPageIndex(table.getPageCount() - 1)}
              disabled={!table.getCanNextPage()}
            >
              {'>>'}
            </button>
            <span className="flex cursor-pointer items-center gap-1">
              <div>Page</div>
              <strong>
                {table.getState().pagination.pageIndex + 1} of {table.getPageCount()}
              </strong>
            </span>
            <span className="flex items-center gap-1">
              | Go to page:
              <input
                type="number"
                defaultValue={table.getState().pagination.pageIndex + 1}
                onChange={(e) => {
                  const page = e.target.value ? Number(e.target.value) - 1 : 0;
                  table.setPageIndex(page);
                }}
                className="w-16 rounded border p-1"
              />
            </span>
            <select
              value={table.getState().pagination.pageSize}
              onChange={(e) => {
                table.setPageSize(Number(e.target.value));
              }}
            >
              {[5, 10, 15, 20, 25].map((pageSize) => (
                <option key={pageSize} value={pageSize}>
                  Show {pageSize}
                </option>
              ))}
            </select>
            <div className="h-4" />
          </div>
        </>
      ) : null}
    </div>
 );
};