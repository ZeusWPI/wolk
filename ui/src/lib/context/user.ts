import type { User } from "$lib/types";
import type { CreateQueryResult } from "@tanstack/svelte-query";
import { getContext, setContext } from "svelte";

const key = Symbol("user");

export const setUserContext = (query: CreateQueryResult<User>) => {
  setContext(key, query);
};

export const getUserContext = () => {
  return getContext<CreateQueryResult<User>>(key);
}
