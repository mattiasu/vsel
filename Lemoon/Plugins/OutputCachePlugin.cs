using System;
using System.Web;
using System.Web.Caching;
using Mindroute.Core;
using Mindroute.Core.Model;
using Mindroute.Core.Plugins;
using Mindroute.Core.Caching;

namespace vsel.Lemoon.Plugins
{

    /// <summary>
    /// A plugin that automatically invalidates cached items that depend on the cache key <see cref="OutputCachePlugin.CacheKey"/>. 
    /// The plugin invalidates the cache items when <see cref="Content"/> and <see cref="Comment"/> items are inserted and/or modified.
    /// </summary>
    [Serializable]
    [Render(Name = "OutputCachePlugin_Name", Description = "OutputCachePlugin_Description", ResourceType = typeof(Properties.Resources))]
    [DefaultValues("IsEnabled", true)]
    public class OutputCachePlugin : Plugin
    {

        /// <summary>
        /// The cache key used as dependency for output caching, i.e. "OutputCachePlugin".
        /// </summary>
        public const string CacheKey = "OutputCachePlugin";

        /// <summary>
        /// Gets a cache dependency that depends on the cache key <see cref="OutputCachePlugin.CacheKey"/>.
        /// </summary>
        public static CacheDependency GetCacheDependency()
        {
            return new CacheDependency(null, new string[] { OutputCachePlugin.CacheKey });
        }

        /// <summary>
        /// Gets a string suitable for VaryByCustom caching. 
        /// </summary>
        /// <returns></returns>
        public static string GetVaryByCustomString()
        {
            var date = HttpRuntime.Cache[CacheKey] as DateTime?;
            if (date == null)
            {
                date = DateTime.UtcNow;
                SetCache(date);
            }
            var custom = date.Value.ToString("s") + "/" + MindrouteContext.Current.Site.LanguageID.ToString();
            return custom;
        }

        /// <summary>
        ///  Inserts/Updates the cache value used as dependency for output caching.
        /// </summary>
        public static void SetCache(DateTime? timestamp = null)
        {
            HttpRuntime.Cache[CacheKey] = timestamp ?? DateTime.UtcNow;
        }

        /// <summary>
        /// Clears cache when content is inserted.
        /// </summary>
        /// <param name="inserted">The inserted <see cref="Content" />.</param>
        public void OnContentInserted(Content inserted)
        {
            SetCache();
        }

        /// <summary>
        /// Clears cache when content is moved.
        /// </summary>
        /// <param name="moved">The inserted <see cref="Content" />.</param>
        public void OnContentMoved(Content source, Content destination)
        {
            SetCache();
        }

        /// <summary>
        /// Clears cache when content is updated.
        /// </summary>
        /// <param name="original">The original <see cref="Content" />.</param>
        /// <param name="updated">The updated <see cref="Content" />.</param>
        public void OnContentUpdated(Content original, Content updated)
        {
            SetCache();
        }

        /// <summary>
        /// Clears cache when content is deleted.
        /// </summary>
        /// <param name="removed">The removed <see cref="Content" />.</param>
        public void OnContentDeleted(Content deleted)
        {
            SetCache();
        }

        /// <summary>
        /// Clears cache when content is removed.
        /// </summary>
        /// <param name="removed">The removed <see cref="Content" />.</param>
        public void OnContentRemoved(Content removed)
        {
            SetCache();
        }

        /// <summary>
        /// Clears cache when comments are inserted.
        /// </summary>
        /// <param name="original">The inserted <see cref="Comment" />.</param>
        public void OnCommentInserted(Comment inserted)
        {
            SetCache();
        }

        /// <summary>
        /// Clears cache when comments are updated.
        /// </summary>
        /// <param name="original">The original <see cref="Comment" />.</param>
        /// <param name="updated">The updated <see cref="Comment" />.</param>
        public void OnCommentUpdated(Comment original, Comment updated)
        {
            SetCache();
        }

        /// <summary>
        /// Clears cache when comments are removed.
        /// </summary>
        /// <param name="removed">The removed <see cref="Comment" />.</param>
        public void OnCommentRemoved(Comment removed)
        {
            SetCache();
        }

        /// <summary>
        /// Clears cache when the internal cache was cleared.
        /// </summary>
        public void OnCacheCleared()
        {
            SetCache();
        }

        /// <summary>
        /// Clears cache when the internal cache was cleared.
        /// </summary>
        /// <param name="region">The cache region that was cleared.</param>
        public void OnCacheRegionCleared(CacheRegion region)
        {
            if (region == CacheRegion.Content || region == CacheRegion.Comment)
            {
                SetCache();
            }
        }
    }
}
