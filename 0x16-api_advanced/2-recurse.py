#!/usr/bin/python3
"""This module contains recursive function"""
import requests


def recurse(subreddit, hot_list=[], after=None):
    """Returns a list containing titles of hot articles"""
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0'}
    params = {'limit': 100, 'after': after}

    try:
        response = requests.get(url,
                                headers=headers,
                                params=params,
                                allow_redirects=False)
        if response.status_code != 200:
            return None

        data = response.json().get('data')
        children = data.get('children')

        for post in children:
            hot_list.append(post.get('data').get('title'))

        after = data.get('after')
        if after is not None:
            return recurse(subreddit, hot_list, after)
        else:
            return hot_list

    except Exception:
        return None
