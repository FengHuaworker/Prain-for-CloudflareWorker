interface Env {
  DB: D1Database;
  KV: KVNamespace;
  ASSETS: Fetcher;
  PRAIN_ENV?: string;
  SESSION_SECRET?: string;
  /** 单站固定为 main（数据表预留 site 字段） */
  SITE?: string;
}

declare module '*.html' {
  const content: string;
  export default content;
}

declare module '*.sql' {
  const content: string;
  export default content;
}
